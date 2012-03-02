FactoryGirl.define do
  factory :user, :class => User do
    sequence(:email)        { |n| "mail_#{n}@example.org" } 
    sequence(:username)     { |n| "user_#{n}" }
    password                'secret'
    password_confirmation   { |u| u.password }
  end
end