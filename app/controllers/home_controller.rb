class HomeController < ApplicationController
  def show
    user_redirect
    @products = Product.all
  end

  def user_redirect
    if !cookies[:giver_id]
      redirect_to landing_show_path
    end
  end
end
