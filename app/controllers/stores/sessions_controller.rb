class Stores::SessionsController < Devise::SessionsController
  layout 'stores'
  protect_from_forgery with: :exception
  before_action :redirect_to_catalog_if_signed_in
  before_action :configure_permitted_params, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    stores_catalog_index_path
  end

  private

  def redirect_to_catalog_if_signed_in
    redirect_to stores_catalog_index_path if store_signed_in?
  end

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
