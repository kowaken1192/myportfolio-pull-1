class PersonalController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show; end

  def edit
    if @user.email == 'guest@example.com'
      flash[:alert] = t('flash.alert.personal.guest_password_not_changeable') 
      redirect_to personal_path  
      return
    end
  end

  def update
    user_params = params.require(:user).permit(:email, :password, :password_confirmation)
    if @user.update(user_params)
      if user_params[:email].present?
        flash[:notice] = t('flash.notice.personal.email_updated')
        redirect_to personal_path(@user)
      else
        flash[:notice] = t('flash.notice.personal.password_updated')
        redirect_to new_user_session_path
      end
    else
      flash.now[:alert] = t('flash.alert.personal.update_failed')
      render 'edit'
    end
  end
    
  private

  def set_user
    @user = User.find(params[:id])
  end
end
