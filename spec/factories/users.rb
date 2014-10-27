FactoryGirl.define do
  factory :user do
    name 'dr. bob'
    sequence(:phone_number, 555_5555) { |n| n }
    sequence(:email) { |n| "#{n}test@test.com"}
    password 'qwertyui'

    after(:create) { |user| user.confirm! }
  end


end
