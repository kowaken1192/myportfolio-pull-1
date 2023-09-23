class UsersController < ApplicationController
  def index
    @posts = current_user.posts
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @favorite_posts = @user.favorite_posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:first_name, :last_name, :email, :profile, :image,:background_image))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to user_path(@user) 
    else
      render "edit"
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end
end
