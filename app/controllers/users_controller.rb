class UsersController < ApplicationController
  before_action :ensure_normal_user, only: :withdraw
  before_action :set_user, only: [:show, :edit, :update, :unsubscribe, :withdraw]

  def index
    @user = current_user
    @posts = current_user.posts.with_counts_and_avg_score
    @favorited_post_ids = current_user.favorites.pluck(:post_id)
  end

  def show
    @posts = @user.posts.with_counts_and_avg_score 
    @favorited_post_ids = @user.favorites.pluck(:post_id) 
  end
  
  def edit; end

  def update
    if @user.update(params.require(:user).permit(:first_name, :last_name, :profile, :image, :background_image))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to users_path
    else
      render "edit"
    end
  end

  def favorites
    @favorited_post_ids = current_user.favorites.pluck(:post_id)
    @favorite_posts = Post.with_counts_and_avg_score.where(id: @favorited_post_ids)
  end
  
  def unsubscribe; end
  
  def withdraw
    if @user
      @user.update(is_valid: false)
      reset_session
      flash[:notice] = t('flash.notice.users.withdrawal_complete')
    else
      flash[:alert] = t('flash.alert.users.user_not_found')
    end
    redirect_to new_user_session_path
  end

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      flash[:alert] = t('flash.alert.users.guest_cannot_delete')
      redirect_to confirm_unsubscribe_user_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end  
