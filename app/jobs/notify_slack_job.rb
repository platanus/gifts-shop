class NotifySlackJob < ApplicationJob
  queue_as :default

  def perform(product)
    NotifyProduct.for(product: product)
  end
end
