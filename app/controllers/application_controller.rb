class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
  
  def save_language
    session[:selected_lang] = params[:lang]
    head :ok
  end
  
  protected

  def after_sign_in_path_for(resource)
    search_post_index_path
  end

  def after_sign_out_path_for(resource)
    posts_path
  end
end
