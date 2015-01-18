FactoryGirl.define do
  factory :users do
    email {Faker::Internet.email}
    password 'monkey123'
    password_confirmation 'monkey123'

  end
end