FactoryBot.define do
  factory :story_view do
    association :user, factory: :user
    association :story, factory: :story
  end
end
