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
  describe 'スッキリ投票機能' do
    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: 'user9@example.com'
      fill_in "パスワード", with: 'password'
      click_on "Log in"
    end
    context ' スッキリ投票を押す' do
      it ' ユーザーがスッキリ投票できる' do
        click_link '好奇心'
        click_on 'スッキリ',match: :first
        expect(page).to have_content '投票をしました！'
      end
    end
  end
end