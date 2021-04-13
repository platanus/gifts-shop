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
      image do
        Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/jpg')
      end
    end
  end
end
