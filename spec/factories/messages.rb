FactoryBot.define do
  factory :message do
    msg {"Rspec - Test Message"}
    attachment {nil}
    association :recipient, factory: :user
    association :sender, factory: :user
  end
end
