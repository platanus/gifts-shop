module CatalogClassHelper
  def catalog_error_class(base_class, has_attachment)
    if !has_attachment
      return "#{base_class} #{base_class}--danger"
    end

    base_class
  end
end
