class PromotedClickAccounterJob < ApplicationJob
  queue_as :default

  def perform(product_action, organization)
    PromotedClickAccounter.for(
      organization: organization,
      store: product_action.store,
      product_action: product_action
    )
  end
end
