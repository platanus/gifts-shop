require 'rails_helper'

RSpec.describe ProductAction, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:product_action)).to be_valid
  end
  it 'is not valid without an action_type' do
    expect(build(:product_action, action_type: nil)).not_to be_valid
  end
  it 'is not valid without a receiver' do
    expect(build(:product_action, receiver_id: nil)).not_to be_valid
  end
  it 'is not valid without a product' do
    expect(build(:product_action, product_id: nil)).not_to be_valid
  end
end
