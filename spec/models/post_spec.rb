require 'rails_helper'
RSpec.describe Post, type: :model do
  let!(:user) { User.create(name: 'user_name', email: 'user@email.com', password: 'password') }
  let!(:post_created_by_user){Post.create(title: 'post_title', description: 'post_content', user_id: user.id)}
    # タイトルと内容あれば有効な状態であること
    context 'ポストのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
       post = Post.new(title: nil , description: '失敗テスト')
        expect(post).not_to be_valid
      end
    end
    # タイトルがなければ無効な状態であること
    context 'ポストのイメージが空の場合' do
      it 'バリデーションに通る' do
    post=Post.new(title: 'post' , description: 'テスト',image:nil,user_id: user.id)
     expect(post).to be_valid
      end
    end
    # 重複したタイトルなら無効な状態であること
    it "is invalid with a duplicate title"
    # タイトルが101文字以上なら無効な状態であること
    it "is invalid with title is 101 or more characters"
  end