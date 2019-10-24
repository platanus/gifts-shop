class HomeController < ApplicationController
  before_action :set_receiver, :set_giver, only: :show
  before_action :redirect_to_landing_if_no_cookies, only: :show

  def show; end

  private

  def redirect_to_landing_if_no_cookies
    if !@giver || !@receiver || @receiver.giver_id != @giver.id
      redirect_to landing_show_path
    end
  end

  def set_receiver
    @receiver = Receiver.find_by(id: cookies[:receiver_id])
  end

  def set_giver
    @giver = Giver.find_by(id: cookies[:giver_id])
  end
end
