class UsersController < ApplicationController
  def index
    @posts = current_user.posts
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:first_name, :last_name, :email, :profile, :image))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to user_path(@user) 
    else
      render "edit"
    end
  end
end
