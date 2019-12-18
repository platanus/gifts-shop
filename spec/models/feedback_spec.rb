require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:receiver) }
    it { is_expected.to validate_presence_of(:response) }
  end

  context 'with valid attributes' do
    it { expect(build(:feedback)).to be_valid }
  end

  context 'without a response' do
    it { expect(build(:feedback, response: nil)).not_to be_valid }
  end

  context 'without a receiver' do
    it { expect(build(:feedback, receiver_id: nil)).not_to be_valid }
  end
end
