FactoryBot.define do
  factory :post do
    association :user, factory: :user
    caption { Faker::Quote.singular_siegler }
    total_likes { 0 }
    total_comments { 0 }

    trait :with_image do
      after(:build) do |post|
        post.image.attach(
          Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Bugatti.png'), 'image/png')
        )
      end
    end

    trait :without_image do
      image { nil }
    end
  end
end
