FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :post, factory: :post
    content { "Request-Spec - TEST COMMENT" }
  end
end
