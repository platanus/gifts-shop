require 'rails_helper'

RSpec.describe Receiver, type: :model do
  it 'is valid with valid attributes' do
    expect(build(:receiver)).to be_valid
  end
  it 'is not valid without a giver' do
    expect(build(:receiver, giver: nil)).not_to be_valid
  end
end
