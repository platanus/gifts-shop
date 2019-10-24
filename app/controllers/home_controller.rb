class HomeController < ApplicationController
  before_action :set_receiver, :set_giver, only: :show
  before_action :check_redirect_to_landing, only: :show

  def show; end

  private

  def check_redirect_to_landing
    if !@giver || !@receiver || @receiver.giver_id != @giver.id
      redirect_to landing_show_path
    end
  end

  def set_receiver
    @receiver = Receiver.find_by(id: session[:receiver_id])
  end

  def set_giver
    @giver = Giver.find_by(id: session[:giver_id])
  end
end
