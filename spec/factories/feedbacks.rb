FactoryBot.define do
  factory :feedback do
    receiver
    response { 1 }
    additional_info { "MyText" }
  end
end
