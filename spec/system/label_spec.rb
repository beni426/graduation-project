require 'rails_helper'

RSpec.describe 'label管理機能', type: :system do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/1.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post,user_id: user.id) }
  let!(:user_second) { FactoryBot.create(:user_second) }
  let!(:post_second) { FactoryBot.create(:post_second, user_id: user_second.id) }
  let!(:post_third) { FactoryBot.create(:post_third, user_id: user_second.id) }
   let!(:label) {create(:label)}
   let(:labelling){create(post_id: Post.last.id, label_id: Label.last.id)}
   describe 'ラベル機能' do
     before do
      visit new_user_session_path
      fill_in "メールアドレス", with: 'user9@example.com'
      fill_in "パスワード", with: 'password'
      click_on "Log in"
    end
    context 'ラベルをポストにつけること' do
        it "投稿の編集する画面でラベルをつけること" do
          visit post_path(1)
           click_on '編集'
           select 'life-2', from: 'label_id'
           click_button '更新する'
          expect(page).to have_text '投稿を更新しました！'
        end
      end
  
      context 'タスク詳細画面でラベルを確認すること' do
        it "タスク詳細画面でラベルを表示すること" do
          visit post_path(1)
          click_on '編集'
          select 'life-5', from: 'label_id'
          click_button '更新する'
          expect(page).to have_content 'life-5'
        end
      end
      # context 'ラベルをポストに外すこと' do
      #   it "投稿の編集する画面でラベルを外すこと" do
      #     visit post_path(1)
      #      click_on '編集'
      #     #  binding.pry
      #      uncheck 'post_label_ids_777'
      #      click_button '更新する'
      #     expect(page).to have_text '投稿を更新しました！'
      #   end
      # end
    describe 'ラベル検索機能' do
      context 'ラベルの検索できること' do
        it "検索キーワードをラベルに含み、一致するタスク絞り込まれる" do
         visit posts_path
      
         select 'life-9', from: 'label_id'
         click_button 'ジャンル別検索'
         expect(page).to have_content 'ここが内容です'
        end
      end
    end
    end
end