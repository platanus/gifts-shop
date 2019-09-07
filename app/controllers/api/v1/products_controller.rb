# frozen_string_literal: true

class Api::V1::ProductsController < Api::V1::BaseController
  def index
    products = recommender_sort(Product.all)
    render json: products
  end

  private

  def recommender_sort(products)
    return products if ENV['RECOMMENDER_URL'].blank?

    number_of_products = products.length
    uri = URI.parse("#{ENV['RECOMMENDER_URL']}/recommend/#{number_of_products}")
    begin
      response = Net::HTTP.get_response(uri)
    rescue Errno::ECONNREFUSED => _
      return products
    end
    if response.code == '200'
      order = JSON.parse(response.body)['product_ids']
      products.sort_by { |product| order.index(product.id) }
    end
    products
  end
end
