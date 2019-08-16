class HomeController < ApplicationController
  before_action :redirect_to_landing_if_no_cookies, only: :show
  def show
    get_receivers_name
    get_products
  end

  def get_receivers_name
    set_receiver_id
    @receiver_name = Receiver.find(@receiver_id).name
  end

  def get_products
    @products = Product.all
  end

  private

  def redirect_to_landing_if_no_cookies
    redirect_to landing_show_path if !set_giver_id
  end

  def set_receiver_id
    @receiver_id = cookies[:receiver_id]
  end

  def set_giver_id
    @giver_id = cookies[:giver_id]
  end
end
