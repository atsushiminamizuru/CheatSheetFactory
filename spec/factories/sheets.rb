FactoryBot.define do
  factory :sheet do
    title { 'MyString' }
    content { 'MyText' }
    genre_id { 1 }
    user { nil }

    after(:build) do |_sheet|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
