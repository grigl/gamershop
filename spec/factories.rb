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

  factory :product, :class => Product do
    sequence(:title)            { |n| "Best game number #{n}" }
    description                 "This is the best game in the world"
    price                       10.99
    platform                    'PC'
    genre                       'RPG'
    publisher                   'Interplay Entertainment'
    developer                   'Valve Software'
    image_url                   'images/best.jpg'
  end

end