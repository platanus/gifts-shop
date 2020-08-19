class ProductObserver < PowerTypes::Observer
  after_create :notify_slack

  def notify_slack
    NotifySlackJob.perform_later(object)
  end
end
