class Api::V1::ProductActionsController < Api::V1::BaseController
  def create
    if permitted_params[:action_type] == 'display'
      respond_with mark_displayed
    else
      puts 'Pendiente para like'
    end
  end

  private

  def mark_displayed
    receiver_id = set_receiver_id
    ProductAction.create!(
      receiver_id: receiver_id,
      product_id: permitted_params[:product_id],
      action_type: permitted_params[:action_type]
    )
  end

  def permitted_params
    params.permit(:product_id, :action_type)
  end

  def set_receiver_id
    cookies[:receiver_id]
  end
end
