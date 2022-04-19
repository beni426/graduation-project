FactoryBot.define do
    factory :labelling do
      association :post
      association :label
    end
  end