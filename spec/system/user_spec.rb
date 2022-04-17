require 'rails_helper'

RSpec.describe "ユーザー機能", type: :system do
    let!(:user) { FactoryBot.create (:user)}
    before do
     @user=User.find_by(email:'user9@example.com')
    end
    describe 'ユーザー登録のテスト' do
      context '各フォームに正しいちを入れる'do
       it 'ユーザーが新規登録される' do
        visit new_user_registration_path
        fill_in '名前', with: 'user7'
        fill_in 'メールアドレス', with: 'user7@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
        click_on 'Sign up'
        expect(page).to have_content 'アカウント登録しました'
       end
    end
      context 'フォームに間違えた値を入れる'do
      it 'ユーザーが新規登録が失敗' do
        visit new_user_registration_path
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: 'user9@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード', with: 'password'
        click_on 'Sign up'
        expect(page).not_to have_content 'アカウント登録が完了しました。'
       end
     end
    end
    describe 'ログイン機能テスト' do
      context '各フォームに正しいちを入れる' do
        it 'ログイン出来る' do
            visit new_user_session_path
            fill_in 'メールアドレス', with: 'user9@example.com'
            fill_in 'パスワード', with: 'password'
            click_button 'Log in'
            expect(page).to have_content 'ログインしました'
        end
      end
    end
    describe 'ログアウト機能' do
     context '各フォームに正しいちを入れる' do
        it 'ログインアウト出来る' do
            visit new_user_session_path
            fill_in 'メールアドレス', with: 'user9@example.com'
            fill_in 'パスワード', with: 'password'
            click_button 'Log in'
            click_on 'ログアウト'
            expect(page).to have_content 'ログアウトしました'
        end
      end
    end
    describe 'ユーザーがマイページを編集機能' do
        context '各フォームに正しいちを入れる' do
           it 'マイページを更新出来る' do
               visit new_user_session_path
               fill_in 'メールアドレス', with: 'user9@example.com'
               fill_in 'パスワード', with: 'password'
               click_button 'Log in'
               click_on 'マイページ'
               click_on 'プロファイル編集'
               fill_in 'パスワード',with: '123456'
               fill_in 'パスワード(確認用)',with: '123456'
               click_on '更新'
               expect(page).to have_content 'プロファイルを編集しました'
           end
         end
       context '各フォームに正しいちを入れる' do
           it 'ユーザープロファイルを更新失敗' do
            visit new_user_session_path
            fill_in 'メールアドレス', with: 'user9@example.com'
            fill_in 'パスワード', with: 'passwrod'
            click_button 'Log in'
            click_on 'マイページ'
            click_on 'プロファイル編集'
            fill_in 'パスワード',with: '123456'
            click_on '更新'
            expect(page).to have_content 'パスワードを入力してください。'
           end
         end
       end
    describe 'ユーザー削除機能テスト' do
        context ' アカウントの削除ボタンを押す' do
            it ' ユーザーが削除される' do
                visit new_user_session_path
                fill_in 'メールアドレス', with: 'user9@example.com'
                fill_in 'パスワード', with: 'password'
                click_button 'ログイン'
                click_on 'マイページ'
                click_on 'プロファイル編集'
                click_on 'アカウントの削除'
                page.accept_confirm '本当にアカウントを削除しますか'
                expect(page).to have_content ''
            end
        end
    end
end

