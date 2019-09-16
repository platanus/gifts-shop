FactoryBot.define do
  factory :product_action do
    product
    receiver
    action_type { 1 }
  end
end
