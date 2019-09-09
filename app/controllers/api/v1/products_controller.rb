class Api::V1::ProductsController < Api::V1::BaseController
  def index
    recommender_service = RecommenderService.new
    products = recommender_service.get_all_products
    render json: products
  end
end
