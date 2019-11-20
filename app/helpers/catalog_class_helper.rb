module CatalogClassHelper
  def catalog_error_class(base_class, product)
    if !product.image.attached?
      return "#{base_class} #{base_class}--danger"
    end

    base_class
  end
end
