require 'rails_helper'
RSpec.describe Post, type: :system do
  let!(:user) { FactoryBot.create(:user)}
  let!(:post){FactoryBot.create(:post, user_id: user.id)}
  let!(:user_second) { FactoryBot.create(:user_second)}
  let!(:post_second){FactoryBot.create(:post_second, user_id: user_second.id)}
  let!(:post_third){FactoryBot.create(:post_third, user_id: user_third.id)}
   before do
    sign_in user
   end
   describe '新規投稿機能' do
    context '投稿を新規作成場合' do
      it '作成した投稿を一覧画面に表示される' do
        visit posts_path
        click_on 'ブログ投稿'
        fill_in 'タイトル',with: 'test'
        fill_in '説明',with: 'I hate it'
        select 'life', from: 'label'
        select 'public',from: 'ステータス'
        click_on ''
    
        expect(page).to have content 'test'
      end
    end
  end