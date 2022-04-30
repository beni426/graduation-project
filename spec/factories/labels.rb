# frozen_string_literal: true

FactoryBot.define do
  factory :label do
    sequence(:genre) { |n| "life-#{n}" }
  end
end
