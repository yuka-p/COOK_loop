class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    home_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :email, :password, :password_confirmation, :current_password])
  end
end
