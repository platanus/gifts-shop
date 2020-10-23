class Api::V1::ProductActionsController < Api::V1::BaseController
  def create
    product_action = save_action(permitted_params[:action_type])
    if permitted_params[:action_type] == 'click'
      save_promoted
      product = Product.find_by(id: permitted_params[:product_id])
      product.add_click
    end
    respond_with product_action
  end

  private

  def save_action(action_type)
    ProductAction.create!(
      product_id: permitted_params[:product_id],
      action_type: action_type
    )
  end

  def permitted_params
    params.require(:product_action).permit(:product_id, :action_type)
  end

  def save_promoted
    product = Product.find_by(id: permitted_params[:product_id])
    if product&.promoted && product&.store&.has_enough_balance?
      save_action('promoted_click')
    end
  end
end
