class Api::V1::ReceiversController < Api::V1::BaseController
  def show
    respond_with receiver if receiver
  end

  def delete_session
    session.delete(:receiver_id)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def receiver
    @receiver ||= Receiver.find_by(id: session[:receiver_id])
  end
end
