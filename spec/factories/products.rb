FactoryBot.define do
  factory :product do
    name { "MyString" }
    price { 1.5 }
    clicks { "" }
    link { "MyString" }
    email { "MyString" }
    description { "MyText" }
    store
    novelty { 3 }
    category
    trait :with_image do
      image { fixture_file_upload(Rails.root.join('spec/fixtures/files/example.jpg'), 'image/jpg') }
    end
  end
end
