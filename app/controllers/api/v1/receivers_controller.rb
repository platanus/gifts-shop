class Api::V1::ReceiversController < Api::V1::BaseController
  def show
    respond_with(receiver: receiver, likes: likes) if receiver
  end

  def delete_session
    session.delete(:receiver_id)
    respond_to do |format|
      format.json { head :ok }
    end
  end

  def likes
    ProductAction.where(action_type: 'like', receiver: receiver).count
  end
end
