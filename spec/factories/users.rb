FactoryBot.define do
    factory :user do 
        name { "Parshwa" }
        email { Faker::Internet.email }
        password { "password" }
        bio { "Hey There, I'm using GetSocial" }
        profile_picture { nil }
        cover_photo { nil }
    end
end