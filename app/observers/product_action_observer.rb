class ProductActionObserver < PowerTypes::Observer
  after_save :execute_promoted_click_accounter

  def execute_promoted_click_accounter
    if object&.promoted_click?
      organization = Organization.find_by(name: 'Platanus')
      PromotedClickAccounterJob.perform_later(object, organization)
    end
  end
end
