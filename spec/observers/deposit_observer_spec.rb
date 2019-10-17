require 'rails_helper'

describe DepositObserver do
  include ActiveJob::TestHelper
  subject(:deposit) { create :deposit }

  def trigger(type, event)
    described_class.trigger(type, event, deposit)
  end

  describe 'after save' do
    it 'enqueues DepositAccounterJob if deposit is created' do
      trigger :after, :save
      expect(DepositAccounterJob).to have_been_enqueued.with(deposit)
    end
  end
end
