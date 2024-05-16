FactoryBot.define do
    factory :notification_preference do
        association :preferred_user, factory: :user
        association :preferred_notifier, factory: :user
    end
  end