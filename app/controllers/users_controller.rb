class UsersController < ApplicationController
  def index
    @posts = current_user.posts.with_counts.with_avg_score
    @user = current_user
    @post = Post.eager_load(:reviews).last
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
end  
