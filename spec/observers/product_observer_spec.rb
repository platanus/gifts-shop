require 'rails_helper'

describe ProductObserver do
  include ActiveJob::TestHelper
  subject(:product) { create :product }

  def trigger(type, event)
    described_class.trigger(type, event, product)
  end

  describe 'after create' do
    it 'enqueues NotifySlackJob if product is created' do
      trigger :after, :create
      expect(NotifySlackJob).to have_been_enqueued.with(product)
    end
  end
end
