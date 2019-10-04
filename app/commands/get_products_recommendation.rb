class GetProductsRecommendation < PowerTypes::Command.new(
  :receiver, :number_of_products, min_price: false, max_price: false
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
    if @min_price && @max_price
      return URI("#{URL}/recommend/#{@receiver.id}/#{@number_of_products}?"\
                 "min_price=#{@min_price}&max_price=#{@max_price}")
    end
    if @min_price
      return URI("#{URL}/recommend/#{@receiver.id}/#{@number_of_products}?min_price=#{@min_price}")
    end
    if @max_price
      return URI("#{URL}/recommend/#{@receiver.id}/#{@number_of_products}?max_price=#{@max_price}")
    end

    URI("#{URL}/recommend/#{@receiver.id}/#{@number_of_products}")
  end

  def perform_recommendation_request
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)['product_ids']
  rescue Errno::ECONNREFUSED, JSON::ParserError
    false
  end
end
