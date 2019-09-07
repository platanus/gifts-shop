# frozen_string_literal: true

class Api::V1::ProductsController < Api::V1::BaseController
  def index
    products = recommender_sort(Product.all)
    render json: products
  end

  private

  def recommender_sort(products)
    number_of_products = products.length
    uri = URI.parse("#{ENV['RECOMMENDER_URL']}/recommend/#{number_of_products}")
    response = Net::HTTP.get_response(uri)
    order = JSON.parse(response.body)['product_ids']
    products.sort_by { |product| order.index(product.id) }
  end
end
