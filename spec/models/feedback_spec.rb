require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:feedback)).to be_valid
  end
  it 'is not valid without a response' do
    expect(build(:feedback, response: nil)).not_to be_valid
  end
  it 'is not valid without a receiver' do
    expect(build(:feedback, receiver_id: nil)).not_to be_valid
  end
end
