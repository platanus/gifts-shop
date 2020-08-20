class ProductObserver < PowerTypes::Observer
  after_create :notify_slack unless Rails.env.development?

  def notify_slack
    NotifySlackJob.perform_later(object)
  end
end
