class PersonalController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      flash[:alert] = t('flash.alert.personal.guest_password_not_changeable') 
      redirect_to personal_path  
      return
    end
  end

  def update
    @user = User.find(params[:id])
    user_params = params.require(:user).permit(:email,:password, :password_confirmation)
    if @user.update(user_params)
      flash[:notice] = t('flash.notice.personal.password_updated')
      redirect_to posts_path  
    else
      flash.now[:alert] = t('flash.alert.personal.password_update_failed')
      render 'edit'
    end
  end
end
