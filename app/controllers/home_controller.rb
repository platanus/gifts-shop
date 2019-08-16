class HomeController < ApplicationController
  before_action :set_receiver_id, :set_giver_id, only: :show
  before_action :redirect_to_landing_if_no_cookies, only: :show

  def show
    receiver
    @products = Product.all
  end

  def receiver
    @receiver = Receiver.find(@receiver_id)
  end

  private

  def redirect_to_landing_if_no_cookies
    redirect_to landing_show_path if !@giver_id
  end

  def set_receiver_id
    @receiver_id = cookies[:receiver_id]
  end

  def set_giver_id
    @giver_id = cookies[:giver_id]
  end
end
