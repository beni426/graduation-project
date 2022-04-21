FactoryBot.define do
  factory :label do
    sequence(:genre) { |n| "life-#{n}" }
  end
end
  