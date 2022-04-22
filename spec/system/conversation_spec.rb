require 'rails_helper'
RSpec.describe Conversation, type: :system do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/1.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post,user_id: user.id) }
  let!(:user_second) { FactoryBot.create(:user_second) }
  let!(:post_second) { FactoryBot.create(:post_second, user_id: user_second.id) }
  describe '一対一会話機能' do
    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: 'user9@example.com'
      fill_in "パスワード", with: 'password'
      click_on "Log in"
    end
    context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
       it '投稿者にメッセージを送ることできる' do
        visit post_path(2)
        click_on 'メッセージ'
        fill_in 'message[body]',with: 'this is a test'
        click_button 'メッセージを送る'
        expect(page).to have_content 'this is a test'
        end
    end 
    context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
      it 'メッセージを確認することできる' do
        visit post_path(2)
        click_on 'メッセージ'
        fill_in 'message[body]',with: 'this is a test'
        click_button 'メッセージを送る'
        click_on 'ログアウト'
        visit new_user_session_path
        fill_in "メールアドレス", with: 'user9@example.com'
        fill_in "パスワード", with: 'password'
        click_on "Log in"
        click_on 'チャットルーム'
        click_link 'user2'
        expect(page).to have_content 'this is a test'
      end
    end 
  end
end