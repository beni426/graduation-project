require 'rails_helper'
Rspec.describe 'コメント機能', type: :system do
    let!(:user){FactoryBot.create(:user)}
    let!(:post){FactoryBot.create(:post)}
    describe 'コメントを送信機能' do
        context 'コメントメッセージを送信' do
            it 'コメントが非同期処理で送信される'　do
                visit new_user_session_path
                fill_in 'メールアドレス', with: 'user9@example.com'
                fill_in 'パスワード', with: 'password'
                click_button 'ログイン'
                click_on ''
                fill_in '', with: 'message'
                click_on ''
                expect(page).to have_content 'message'
            end
         end
       end
    end
