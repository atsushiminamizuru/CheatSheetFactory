FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.characters(number: rand(1..100)) }

    association :user, factory: :user
    association :sheet, factory: :sheet
  end
end
