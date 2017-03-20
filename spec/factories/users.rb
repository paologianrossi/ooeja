FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john.doe#{n}@example.com" }
    password "s3cr3t!"
  end
end
