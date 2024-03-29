class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
    
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
   
  protected

  def after_sign_in_path_for(resource)
    service_index_path
  end

  def after_sign_out_path_for(resource)
    homes_path
  end
end
