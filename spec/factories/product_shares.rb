FactoryBot.define do
  factory :product_share do
    platform { "email" }
    to_email { "example@platan.us" }
    product
  end
end
