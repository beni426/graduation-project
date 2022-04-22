require 'rails_helper'
RSpec.describe Post, type: :system do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/1.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post,user_id: user.id) }
  let!(:user_second) { FactoryBot.create(:user_second) }
  let!(:post_second) { FactoryBot.create(:post_second, user_id: user_second.id) }
  # let!(:post_third) { FactoryBot.create(:post_third, user_id: user_second.id) }
   let!(:label) {create(:label)}
   let(:labelling){create(post_id: Post.last.id, label_id: Label.last.id)}
   describe '新規投稿機能' do
    before do
     sign_in user
    end
     context '投稿を新規作成場合' do
       it '作成した投稿を一覧画面に表示される' do
         visit posts_path
         click_on 'ブログ投稿'
         fill_in 'タイトル', with: 'Ruby'
         fill_in '説明', with: 'ここが内容です'
         check label.genre
         page.attach_file("#{Rails.root}/spec/fixtures/1.jpg") do
          page.find('#post_image').click
         end 
         click_on '登録'
         expect(page).to have content 'ここが内容です'
      end
     end
    context '任意の記事の詳細画面に遷移した場合' do
      it '作成した投稿を詳細ページに表示される' do
            visit post_path(1)
            expect(page).to have_content 'ここが内容です'
          end
        end
    context '自分が投稿した記事の詳細画面に遷移した場合' do
      it '作成した投稿を編集できること' do
          visit post_path(1)
        
           click_on '編集'
           expect(edit_post_path(1)).to eq edit_post_path(1)
      end
    end
    context '自分が投稿した記事の詳細画面に遷移した場合' do
       it '作成した投稿を削除できること' do
          visit post_path(1)
          click_on '削除'
          expect(page.driver.browser.switch_to.alert.text).to eq  '本当に削除していいですか？' 
      end
    end 
   describe '投稿の詳細ページ各機能' do
    context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
      it '投稿をストックできること' do
         visit post_path(2)
         click_on 'ストック'
         expect(page).to have_content 'user2さんの愚痴をストックしました' 
      end
    end 
    context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
      it '投稿をストックを解除できること' do
       visit post_path(2)
       click_on 'ストック'
       sleep 2
       click_on 'たのしい'
       expect(page).to have_content 'ストックを解除する' 
     end
    end
    context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
      it '投稿者のマイページをみることできる' do
          visit post_path(1)
           click_on 'user9'
           expect(user_path(1)).to eq user_path(1)
      end
     end 
    context '他のユーザーが投稿した記事の詳細画面に遷移した場合' do
      it '投稿者にメッセージを送ることできる' do
        visit post_path(2)
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
       find('.fa-edit').click
       expect(page).to have_button '更新する'
     end
    end 
    context 'ユーザーが投稿した記事の詳細画面に遷移した場合' do
     it 'コメントを削除ことできる' do
       visit post_path(1)
       fill_in 'comment_content', with: 'nice'
       click_on '登録する'
       find('.fa-trash-alt').click
       expect(page.driver.browser.switch_to.alert.text).to eq  "本当に削除しますか?"
      end
     end 
     end
  end
end
