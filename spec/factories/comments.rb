FactoryBot.define do
  factory :comment do
    text { 'MyText' }
    user { nil }
    sheet { nil }
  end
end
