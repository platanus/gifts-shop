module ApplicationHelper
  DEFAULT_REGION = ENV.fetch('DEFAULT_REGION', 1).to_i
  DEFAULT_DISPLAY = ENV.fetch('DEFAULT_DISPLAY', true)

  def default_region
    DEFAULT_REGION
  end

  def default_display
    DEFAULT_DISPLAY
  end

  def image_hint(image)
    return image_tag(url_for(image), size: 250, class: 'aa-product__image') if image.attached?

    content_tag(:span, 'Sin imagen')
  end
end
