class GetProductsRecommendation < PowerTypes::Command.new(:receiver, :number_of_products)
  URL = ENV.fetch('RECOMMENDER_URL')
  def perform
    if product_ids = perform_recommendation_request
      Product.find_with_order(product_ids)
    else
      Product.first(@number_of_products)
    end
  end

  private

  def uri
    URI("#{URL}/recommend/#{@receiver.id}/#{@number_of_products}")
  end

  def perform_recommendation_request
    begin
      response = Net::HTTP.get_response(uri)
    rescue Errno::ECONNREFUSED => _
      return false
    end
    JSON.parse(response.body)['product_ids']
  end
end