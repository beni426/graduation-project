FactoryBot.define do
    factory :user, class: User do
      name { "user9" }
      email { "user9@example.com" }
      password { "password" }
      password_confirmation {"password"}
      admin { 'false'}
    
    end
    factory :user_second, class: User do
      name { "user2" }
      email { "user2@example.com" }
      password { "password" }
      password_confirmation {"password"}
      admin {'false'}
     
    end
end