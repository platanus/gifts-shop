class Stores::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    stores_catalog_show_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :region_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :password, :region_id])
  end
end
