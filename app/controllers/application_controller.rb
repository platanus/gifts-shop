class ApplicationController < ActionController::Base
  private

  def giver
    @giver ||= Giver.find_by(id: session[:giver_id])
  end

  def receiver
    @receiver ||= Receiver.find_by(id: session[:receiver_id])
  end
end
