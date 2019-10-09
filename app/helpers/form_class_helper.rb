module FormClassHelper
  def html_error_class(base_class, error_name = nil)
    if !error_name
      if flash[:alert]
        return "#{base_class} #{base_class}--danger"
      end
    elsif resource.errors.include?(error_name)
      return "#{base_class} #{base_class}--danger"
    end
    base_class
  end
end
