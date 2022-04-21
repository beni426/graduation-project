require 'rails_helper'
RSpec.describe 'コメント機能', type: :system do
    let!(:user_second){FactoryBot.create(:user_second)}
    let!(:post){FactoryBot.create(:post)}
    describe 'コメントを送信機能' do
        context 'コメントメッセージを送信' do
            it 'コメントが非同期処理で送信される' do
                visit new_user_session_path
                fill_in 'メールアドレス', with: 'user9@example.com'
                fill_in 'パスワード', with: 'password'
                click_button 'Log in'
                click_on 'ホーム'
               
                click_on 'Ruby'
                fill_in 'comment_content', with: 'message'
                click_on '登録する'
                sleep 2
                expect(page).to have_content 'message'
            end
         end
         context 'コメントメッセージを送信' do
            it 'コメントを編集できること' do
                visit new_user_session_path
                fill_in 'メールアドレス', with: 'user9@example.com'
                fill_in 'パスワード', with: 'password'
                click_button 'Log in'
                click_on 'ホーム'
                click_on 'Ruby'
                fill_in 'comment_content', with: 'message'
                click_on '登録する'
                find('.fa-edit').click
                fill_in 'comment_content_1', with: 'message11'
                click_on '更新する'
                sleep 2
                expect(page).to have_content 'message11'
            end
         end
         context 'コメントメッセージを送信' do
            it 'コメントを編集できること' do
                visit new_user_session_path
                fill_in 'メールアドレス', with: 'user9@example.com'
                fill_in 'パスワード', with: 'password'
                click_button 'Log in'
                click_on 'ホーム'
                click_on 'Ruby'
                fill_in 'comment_content', with: 'message'
                click_on '登録する'
                find('.fa-trash-alt').click
                sleep 2
                expect(page.driver.browser.switch_to.alert.text).to eq  "本当に削除しますか?"
            end
         end
       end
    end
