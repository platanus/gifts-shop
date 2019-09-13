class Api::V1::ProductActionsController < Api::V1::BaseController
  def create
    mark_displayed
  end

  private

  def mark_displayed
    products = permitted_params
    # puts products
    receiver_id = set_receiver_id
    # puts receiver_id
    # ProductAction.create!(
    #   receiver_id: receiver_id,
    #   product_id: params[:id],
    #   action_type: 0
    # )
  end

  def permitted_params
    params.permit(products: {})
  end

  def set_receiver_id
    cookies[:receiver_id]
  end
end
