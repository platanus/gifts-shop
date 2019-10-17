class UpdateStoreProducts < PowerTypes::Command.new(:store, :csv_url)
  def perform
    @store.products.destroy_all
    products.each do |params|
      if product = Product.create(
        name: params.name,
        link: params.link,
        price: params.price,
        store_id: @store.id
      )
        product.attach_image_from_url(params.image)
      end
    rescue OpenURI::HTTPError
      next
    end
  end

  private

  def products
    parser = StoreProductsParser.new
    parser.run(@csv_url)
  end
end
