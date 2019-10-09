module ApplicationHelper
  DEFAULT_REGION = ENV.fetch('DEFAULT_REGION', 1).to_i

  def default_region
    DEFAULT_REGION
  end
end
