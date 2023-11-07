class UsersController < ApplicationController
  before_action :ensure_normal_user, only: :withdraw
  def index
    @posts = current_user.posts.with_counts.with_avg_score
    @user = current_user
    @favorited_post_ids = current_user.favorites.pluck(:post_id)
  end

  def show
    @user = current_user
    @posts = current_user.posts.with_counts.with_avg_score
    @favorited_post_ids = current_user.favorites.pluck(:post_id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:first_name, :last_name, :email, :profile, :image, :background_image))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to users_path
    else
      render "edit"
    end
  end

  def favorites
    @favorited_post_ids = current_user.favorites.pluck(:post_id)
    @favorite_posts = Post.with_counts.with_avg_score.where(id: @favorited_post_ids)
  end
  
  def unsubscribe
    @user = User.find(params[:id])
  end
  
  def withdraw
    @user = User.find(params[:id])
    if @user
      @user.update(is_valid: false)
      reset_session
      flash[:notice] = t('flash..notice.users.withdrawal_complete') 
      redirect_to root_path
    else
      flash[:alert] = t('flash.alert.users.user_not_found') 
      redirect_to root_path
    end
  end

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      flash[:alert] = t('flash.alert.users.guest_cannot_delete')
      redirect_to confirm_unsubscribe_path
    end
  end
end  
