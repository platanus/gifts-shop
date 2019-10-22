class GetProductsRecommendation < PowerTypes::Command.new(
  :receiver, :number_of_products, :promoted, min_price: false, max_price: false
)
  URL = ENV.fetch('RECOMMENDER_URL')
  def perform
    if product_ids = perform_recommendation_request
      Product.find_with_order(product_ids)
    else
      Product.first(@number_of_products.to_i)
    end
  end

  private

  def uri
    params = []
    params.push("min_price=#{@min_price}") if @min_price
    params.push("max_price=#{@max_price}") if @max_price
    params.push("min_promoted=#{@promoted}") if @promoted
    URI("#{URL}/recommend/#{@receiver.id}/#{@number_of_products}?#{params.join('&')}")
  end

  def perform_recommendation_request
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)['product_ids']
  rescue Errno::ECONNREFUSED, JSON::ParserError
    false
  end
end
