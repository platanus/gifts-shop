class HomeController < ApplicationController
  before_action :set_receiver_id, :set_giver_id, only: :show
  before_action :redirect_to_landing_if_no_cookies, only: :show

  def show
    @receiver = Receiver.find(@receiver_id)
    @products = Product.all
  end

  private

  def redirect_to_landing_if_no_cookies
    if current_store
      redirect_to stores_catalog_show_path
    elsif !@giver_id
      redirect_to landing_show_path
    end
  end

  def set_receiver_id
    @receiver_id = cookies[:receiver_id]
  end

  def set_giver_id
    @giver_id = cookies[:giver_id]
  end
end
