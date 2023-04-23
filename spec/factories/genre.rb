FactoryBot.define do
  factory :genre do
    id { Faker::Number.between(from: 1, to: 10) }
    name { 'Ruby' }
  end
end
