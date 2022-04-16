require 'rails_helper'
RSpec.describe Post, type: :system do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/1.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  # let!(:user) { FactoryBot.create(:user) }
  #  let!(:post) { FactoryBot.create(:post) }
  # let!(:user_second) { FactoryBot.create(:user_second) }
  # let!(:post_second) { FactoryBot.create(:post_second, user_id: user_second.id) }
  # let!(:post_third) { FactoryBot.create(:post_third, user_id: user_second.id) }
  # let!(:label) {create(:label)}
  # let(:labelling){create(:labelling)}
   describe '新規投稿機能' do
    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: 'user1@test.com'
      fill_in "パスワード", with: '111111'
      click_on "Log in"
    end
    # context '投稿を新規作成場合' do
    #   it '作成した投稿を一覧画面に表示される' do
    #     visit posts_path
    #     click_on 'ブログ投稿'
    #     fill_in 'タイトル', with: 'Ruby'
    #     fill_in '説明', with: 'ここが内容です'
    #     select 'life1', from: 'label_id'
    #     page.attach_file("#{Rails.root}/home/beni/workspace/graduation/kiraibar/spec/fixtures/1.jpg") do
    #     binding.pry
    #       page.find('.uploader').click
    #     end 
        
    #     click_on '登録'
    #     expect(page).to have content 'test'
    #   end
    # end
    context '任意の記事の詳細画面に遷移した場合' do
      it '作成した投稿を詳細ページに表示される' do
            visit post_path(1)
            expect(page).to have_content 'post0'
          end
        end
    context '自分が投稿した記事の詳細画面に遷移した場合' do
      it '作成した投稿を編集できること' do
          visit post_path(2)
           click_on '編集'
           expect(edit_post_path(2)).to eq edit_post_path(2)
      end
    end
    context '自分が投稿した記事の詳細画面に遷移した場合' do
       it '作成した投稿を削除できること' do
          visit post_path(2)
          click_on '削除'
          expect(page.driver.browser.switch_to.alert.text).to eq  '本当に削除していいですか？' 
      end
    end 
    context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
      it '投稿をストックできること' do
         visit post_path(1)
         click_on 'ストック'
         expect(page).to have_content 'user0さんの愚痴をストックしました' 
     end
   end 
   context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
      it '投稿者のマイページをみることできる' do
          visit post_path(1)
           click_on 'user0'
           expect(user_path(2)).to eq user_path(2)
    end
   end 
   context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
     it '投稿者にメッセージを送ることできる' do
        visit post_path(1)
        click_on 'メッセージ'
          expect(conversation_path(1)).to eq conversation_path(1)
     end
   end 
   context 'ユーザーが投稿した記事の詳細画面に遷移した場合' do
    it 'コメントを送ることできる' do
       visit post_path(1)
       fill_in 'comment_content', with: 'nice'
       click_on '登録する'
       expect(page).to have_content 'nice'
    end
  end 
  context 'ユーザーが投稿した記事の詳細画面に遷移した場合' do
    it 'コメントを編集ことできる' do
       visit post_path(1)
       fill_in 'comment_content', with: 'nice'
       click_on '登録する'
       expect(page).to have_content 'nice'
    end
  end 
  context 'ユーザーが投稿した記事の詳細画面に遷移した場合' do
    it 'コメントを編集ことできる' do
       visit post_path(1)
       fill_in 'comment_content', with: 'nice'
       click_on '登録する'
       click_on  'i.far.fa-edit'
       expect(page).to have_content '更新する'
    end
  end 

  end
end
