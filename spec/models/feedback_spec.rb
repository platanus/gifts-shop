require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:receiver) }
  end

  context 'with valid attributes' do
    it { expect(build(:feedback)).to be_valid }
  end

  context 'without fulfillment' do
    it { expect(build(:feedback, fulfilled: nil)).not_to be_valid }
  end

  context 'without a receiver' do
    it { expect(build(:feedback, receiver_id: nil)).not_to be_valid }
  end
end
