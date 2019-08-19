class Stores::SessionsController < Devise::RegistrationsController
  def after_sign_in_path_for(_resource)
    stores_catalog_show_path
  end
end
