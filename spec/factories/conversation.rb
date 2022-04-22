FactoryBot.define do
factory :target_user, class: Conversation do
        from_sender_id { User.find_by(email: 'user9@example.com').id}
        to_receiver_id { User.find_by(email: 'user2@example.com').id}
  end
  factory :conversation do
  end