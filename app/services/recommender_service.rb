class RecommenderService < PowerTypes::Service.new
  URL = ENV['RECOMMENDER_URL']

  def get_all_products
    get_products(Product.count)
  end

  def get_products(num_of_products, receiver = nil)
    return get_random_products(num_of_products) if URL.blank?

    uri = products_uri(num_of_products, receiver)
    ids = get_products_ids(uri)
    return get_random_products(num_of_products) if ids.empty?

    Product.find_with_order(ids)
  end

  private

  def products_uri(num_of_products, receiver = nil)
    path = if receiver.nil?
             "#{URL}/recommend/#{num_of_products}"
           else
             "#{URL}/recommend/#{receiver}/#{num_of_products}"
           end

    URI(path)
  end

  def get_products_ids(uri)
    begin
      response = Net::HTTP.get_response(uri)
    rescue Errno::ECONNREFUSED => _
      return []
    end
    if response.code == '200'
      return JSON.parse(response.body)['product_ids']
    end

    []
  end

  def get_random_products(num_of_products)
    Product.order('RANDOM()').limit(num_of_products)
  end
end
