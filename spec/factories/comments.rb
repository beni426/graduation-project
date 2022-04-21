FactoryBot.define do
  factory :comment do
    content     {'mmmmm'}
    # association :user
    association :post
  end
end
  