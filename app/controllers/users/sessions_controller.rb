# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_user, only: [:create]
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to profile_index_path, notice: t('flash.notice.sessions.guest_signed_in')
  end  

  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    # ゲストユーザーでない、かつ退会済みの場合のみリダイレクト
    if @user && !@user.guest? && @user.valid_password?(params[:user][:password]) && !@user.is_valid
      flash[:notice] = t('flash.notice.sessions.account_inactive')
      redirect_to new_user_registration_path
    end
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
