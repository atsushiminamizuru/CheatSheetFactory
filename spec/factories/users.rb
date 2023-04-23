FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name[0..19] }
    email                 { Faker::Internet.free_email }
    password              { "#{Faker::Alphanumeric.alpha(number: 6)}1a" }
    password_confirmation { password }
    introduction          { Faker::Lorem.sentence(word_count: 10)[0..199] }

    after(:build) do |user|
      user.profile_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
