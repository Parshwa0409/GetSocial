FactoryBot.define do
  factory :post do
    association :user, factory: :user
    caption {"I'm excited to share this on GetSocial"}

    after(:build) do |post|
      # Assuming the image file is located in spec/fixtures/files
      post.image.attach(
        Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Bugatti.png'), 'image/png')
      )
    end
    
  end
end
