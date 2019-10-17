require 'rails_helper'

describe ProductActionObserver do
  include ActiveJob::TestHelper
  subject(:product_action) { create :product_action, action_type: action_type }

  let(:action_type) { "click" }

  def trigger(type, event)
    described_class.trigger(type, event, product_action)
  end

  describe 'after save' do
    it 'doesnt enqueue PromotedClickAccounterJob if action is not promoted_click' do
      trigger :after, :save
      expect(PromotedClickAccounterJob).to have_been_enqueued.exactly(0).times
    end

    context "with action type promoted_click" do
      let(:action_type) { "promoted_click" }

      it 'enqueues PromotedClickAccounterJob' do
        organization = create :organization
        trigger :after, :save
        expect(PromotedClickAccounterJob).to have_been_enqueued.with(product_action, organization)
      end
    end
  end
end
