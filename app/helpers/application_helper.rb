module ApplicationHelper
  DEFAULT_REGION = ENV.fetch('DEFAULT_REGION', 1).to_i
  DEFAULT_DISPLAY = ENV.fetch('DEFAULT_REGION', true)

  def default_region
    DEFAULT_REGION
  end

  def default_display
    DEFAULT_DISPLAY
  end
end
