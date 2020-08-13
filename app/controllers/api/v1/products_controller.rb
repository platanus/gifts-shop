class Api::V1::ProductsController < Api::V1::BaseController
  before_action :redirect_to_landing_if_receiver_not_valid, only: :index
  before_action :set_initial_seed

  def index
    products = GetProductsRecommendation.for(
      receiver: receiver,
      number_of_products: recommendation_params[:number_of_products],
      min_price: recommendation_params[:min_price],
      max_price: recommendation_params[:max_price],
      promoted: recommendation_params[:promoted],
      page: recommendation_params[:page],
      seed: session[:seed]
    )
    serialized_products = ActiveModel::ArraySerializer.new(
      products,
      each_serializer: ProductSerializer
    )
    unless products.next_page
      srand
      session[:seed] = rand(-1.0...1.0)
    end
    @response = { products: serialized_products, next_page: products.next_page || 1 }
    respond_with @response
  end

  def update
    product = Product.find_by(id: update_params[:id]).toggle(update_params[:type]).save
    respond_with product
  end

  private

  def recommendation_params
    params.require(:number_of_products)
    params.permit(:number_of_products, :min_price, :max_price, :promoted, :page)
  end

  def update_params
    params.permit(:id, :type)
  end

  def redirect_to_landing_if_receiver_not_valid
    redirect_to landing_show_path unless receiver_is_valid?
  end

  def receiver_is_valid?
    receiver && giver && (receiver.giver_id == giver.id)
  end

  def set_initial_seed
    srand
    session[:set_initial_seed] ||= rand(-1.0...1.0)
  end
end
