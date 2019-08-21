class Stores::SessionsController < Devise::SessionsController
  protect_from_forgery with: :exception
  before_action :configure_permitted_params, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    stores_catalog_show_path
  end

  private

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
