FactoryGirl.define do
  
  factory :user, :class => User do
    sequence(:email)        { |n| "mail_#{n}@example.org" } 
    sequence(:username)     { |n| "user_#{n}" }
    password                'secret'
    password_confirmation   { |u| u.password }

    factory :active_user do
      active   true
    
      factory :admin do
        admin true
      end 

    end
    
  end

end