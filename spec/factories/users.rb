FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "TestUser#{n}" }
    sequence(:email) {|n| "person#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end
