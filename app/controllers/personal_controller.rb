class PersonalController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    user_params = params.require(:user).permit(:email,:password, :password_confirmation)
    if @user.update(user_params)
      flash[:notice] = 'パスワード更新しました'
      redirect_to posts_index_path  
    else
      flash.now[:alert] = 'パスワードの更新に失敗しました'
      render 'edit'
    end
  end
end
