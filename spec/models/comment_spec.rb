# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  # let!(:user) { User.create(name: 'user_name', email: 'user@email.com', password: 'password') }
  before do
    # user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)
    @comment = FactoryBot.build(:comment, post_id: post.id)
    sleep 0.2
  end
  context 'コメントを保存できない場合' do
    it 'コメントが空では投稿できない' do
      @comment.content = ''
      @comment.valid?
      expect(@comment.errors.full_messages).to include 'Contentを入力してください'
    end

    it 'ユーザーがログインしていなければコメントできない' do
      @comment.post_id = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include 'Postを入力してください'
    end

    it '投稿したものがなければコメントできない' do
      @comment.post_id = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include 'Postを入力してください'
    end
  end
end
