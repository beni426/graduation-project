# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    name { 'user9' }
    email { 'user9@example.com' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/user_default.png')) }
    password { 'password' }
    password_confirmation { 'password' }
    admin { 'false' }
  end
  factory :user_second, class: User do
    name { 'user2' }
    email { 'user2@example.com' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/user_default.png')) }
    password { 'password' }
    password_confirmation { 'password' }
    admin { 'false' }
  end
  factory :user_third, class: User do
    name { 'admin1' }
    email { 'admin1@example.com' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/user_default.png')) }
    password { 'password' }
    password_confirmation { 'password' }
    admin { 'true' }
  end
end
