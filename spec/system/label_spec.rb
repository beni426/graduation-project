require 'rails_helper'

RSpec.describe 'label管理機能', type: :system do
    let!(:user) { FactoryBot.create(:user, name: "ユーザー", email: "login@example.com", password: "password", password_confirmation: "password") }
    let!(:post) { FactoryBot.create(:post, title: "test1", description: 'tsrs is test1', status: "public") }
    let(:label) { create(:label) }
    let(:labelling){create(:labelling)}
    describe '検索機能' do
     before do
       visit new_session_path
       fill_in "Email", with: user.email
       fill_in "Password", with: user.password
       click_on "Log in"
    end
    context 'ラベルをポストにつけること' do
        it "編集する画面でラベルをつけること" do
          visit posts_path
          click_on 'user0'
          check 'education'
          click_button '更新'
          expect(page).to have_text '記事を編集しました！'
        end
      end
      context 'タスク詳細画面でラベルを確認すること' do
        it "タスク詳細画面でタスクを表示すること" do
          click_on '詳細確認'
          expect(page).to have_content 'Label'
        end
      end
 
    context 'ラベルの検索できること' do
        it "検索キーワードをラベルに含み、一致するタスク絞り込まれる" do
        
         select 'label-3', from: 'label_id'
         click_button 'search'
          expect(Post.label_search('post')).to include 
        end
      end
    end
end