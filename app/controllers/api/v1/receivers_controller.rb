class Api::V1::ReceiversController < Api::V1::BaseController
  def show
    respond_with receiver if receiver
  end

  private

  def receiver
    @receiver ||= Receiver.find_by(id: permitted_params)
  end

  def permitted_params
    params.require(:id)
  end
end
