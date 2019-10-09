class Stores::RegistrationsController < Devise::RegistrationsController
  layout 'stores'
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    stores_catalog_path
  end

  private

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :region_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :password])
  end
end
