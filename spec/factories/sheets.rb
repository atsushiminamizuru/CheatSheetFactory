FactoryBot.define do
  factory :sheet do
    title   { Faker::Lorem.characters(number: rand(1..50)) }
    content { Faker::Lorem.characters(number: rand(1..300)) }

    after(:build) do |sheet|
      sheet.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    association :user, factory: :user
    association :genre, factory: :genre
  end
end
