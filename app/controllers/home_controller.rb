class HomeController < ApplicationController
  def show
    user_redirect
  end

  def user_redirect
    if !get_giver_cookies
      redirect_to landing_show_path
    else
      get_receivers_name
      get_products
    end
  end

  def get_receivers_name
    get_receiver_cookies
    @receiver_name = Receiver.find(@receiver_id).name
  end

  def get_products
    @products = Product.all
  end

  private

  def get_receiver_cookies
    @receiver_id = cookies[:receiver_id]
  end

  def get_giver_cookies
    @giver_id = cookies[:giver_id]
  end
end
