require 'rails_helper'
RSpec.describe User, type: :model do
  let!(:user){ User.create(name: 'user_name', email: 'user@email.com', password: 'password') }
  describe 'ユーザー登録' do
    it "name、email、passwordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid 
    end
  end
  context 'ユーザーのnameが空の場合' do
    it "is invalid without a name" do
      user = User.new(
        name:'',
        email: "user1@user.com",
        password: "user1pass",
        password_confirmation: 'user1pass',
        image: nil
      )
        expect(user).not_to be_valid
    end
  end
  context 'ユーザーのimageが空の場合' do
     it "is valid with a email and password" do
      user = User.new(
      name:'username',
      email: "user1@user.com",
      password: "user1pass",
      password_confirmation: 'user1pass',
      image: nil
      )
      expect(user).to be_valid
     end
  end
  context 'ユーザーのemailが被った場合' do
    it "is invalid with a email that has been used" do
      user = User.new(
        name:'username',
        email: "user@email.com",
        password: "user1pass",
        password_confirmation: 'user1pass',
        image: nil
      )
        expect(user).not_to be_valid
     end
  end
end

