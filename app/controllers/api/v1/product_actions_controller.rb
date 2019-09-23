class Api::V1::ProductActionsController < Api::V1::BaseController
  def create
    product_action = ProductAction.create!(
      receiver_id: receiver_id,
      product_id: permitted_params[:product_id],
      action_type: permitted_params[:action_type]
    )
    respond_with product_action
  end

  private

  def permitted_params
    params.require(:product_action).permit(:product_id, :action_type)
  end

  def receiver_id
    cookies[:receiver_id]
  end
end
