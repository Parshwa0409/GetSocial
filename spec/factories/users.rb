FactoryBot.define do
    factory :user do 
        name { Faker::Name.name }
        email { Faker::Internet.email }
        password { Faker::Internet.password(min_length: 8) }
        bio { Faker::Quote.yoda }
        profile_picture { nil }
        cover_photo { nil }
    end
end