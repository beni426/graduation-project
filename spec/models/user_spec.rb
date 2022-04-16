require 'rails_helper'
RSpec.describe User, type: :model do
  let!(:user) { User.create(name: 'user_name', email: 'user@email.com', password: 'password') }

  context 'ユーザーのネームが空の場合' do
    it 'バリデーションにひっかかる' do
      user = User.new(name: nil, email: 'user@email.com', password: 'password')
      expect(user).not_to be_valid
    end
  end
  context 'ユーザーのemailが被ったの場合' do
    it 'バリデーションにひっかかる' do
      user = User.new(name: 'user', email: '234@dom.com', password: 'password', image: nil)
      user2 = User.new(name: 'user2', email: '234@dom.com', password: 'password', image: nil)
      expect(user2).not_to be_valid
    end
  end
end
