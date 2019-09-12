class Api::V1::ProductsController < Api::V1::BaseController
  before_action :redirect_to_landing_if_receiver_not_valid, only: :index

  def index
    products = GetProductsRecommendation.for(cookies[:receiver_id], 5)
    render json: products
  end

  private

  def redirect_to_landing_if_receiver_not_valid
    redirect_to landing_show_path unless receiver_is_valid?
  end

  def receiver_is_valid?
    if receiver_id = cookies[:receiver_id]
      Receiver.find(receiver_id).giver_id == cookies[:giver_id]
    else
      false
    end
  end
end
