FactoryBot.define do
  factory :sheet do
    title { 'MyString' }
    content { 'MyText' }
    genre_id { 1 }
    user { nil }
  end
end
