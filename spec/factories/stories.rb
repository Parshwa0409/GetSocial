# spec/factories/story_spec_factory_bot.rb
FactoryBot.define do
  factory :story do
    association :user, factory: :user

    trait :with_picture do
      after(:build) do |story|
        story.pic.attach(
          Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Bugatti.png'), 'image/png')
        )
      end
    end

    trait :without_picture do
    end

  end
end
