# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content     { 'mmmmm' }
    # association :user
    association :post
  end
end
