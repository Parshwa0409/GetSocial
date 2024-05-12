FactoryBot.define do
  factory :message do
    msg { "Rspec - Test Message" }
    association :recipient, factory: :user
    association :sender, factory: :user

    trait :with_attachment do
      after(:build) do |message|
        message.attachment.attach(
          Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Bugatti.png'), 'image/png')
        )
      end
    end

    trait :without_attachment do
      attachment { nil }
    end
  end
end
