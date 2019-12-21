FactoryBot.define do
  factory :feedback do
    receiver
    fulfilled { false }
    additional_info { "MyText" }
  end
end
