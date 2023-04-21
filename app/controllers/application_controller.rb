class ApplicationController < ActionController::Base
  # Filter that requires user authentication for all actions in controllers that inherit from ApplicationController
  before_action :authenticate_user!

  # Filter that permits certain parameters for Devise sign in and sign up
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Method that configures permitted parameters for Devise sign in and sign up
  def configure_permitted_parameters
    # Permit email and encrypted_password for Devise sign in
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :encrypted_password)
    end

    # Permit name, email, password, and password_confirmation for Devise sign up
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation)
    end
  end
end

