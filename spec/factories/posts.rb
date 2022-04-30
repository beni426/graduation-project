# frozen_string_literal: true

FactoryBot.define do
  factory :post, class: Post do
    id { '1' }
    title { 'Ruby' }
    description { 'ここが内容です' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/1.jpg')) }
    created_at { '2022-01-01T00:00:00Z' }
    updated_at { '2022-01-02T00:00:00Z' }
    after(:create) do |post|
      create_list(:labelling, 1, post: post, label: create(:label))
    end
    association :user, factory: :user
  end
  factory :post_second, class: Post do
    id { '2' }
    title { 'たのしい' }
    description { '内容' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/1.jpg'), 'spec/fixtures/1.jpg') }
    created_at { '2022-01-02T00:00:00Z' }
    updated_at { '2022-01-03T00:00:00Z' }
    after(:create) do |post|
      create_list(:labelling, 1, post: post, label: create(:label))
    end
    association :user, factory: :user
  end
  factory :post_third, class: Post do
    id { '3' }
    title { 'test3' }
    description { 'ここがtest3です' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/1.jpg')) }
    created_at { '2022-01-03T00:00:00Z' }
    updated_at { '2022-01-04T00:00:00Z' }
    after(:create) do |post|
      create_list(:labelling, 1, post: post, label: create(:label))
    end
    association :user, factory: :user
  end
  factory :post_last, class: Post do
    id { '4' }
    title { 'test4' }
    description { 'ここがtest4です' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/1.jpg')) }
    created_at { '2022-01-03T00:00:00Z' }
    updated_at { '2022-01-04T00:00:00Z' }
    after(:create) do |post|
      create_list(:labelling, 1, post: post, label: create(:label))
    end
    association :user, factory: :user
  end
end
