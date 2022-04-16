require 'rails_helper'
RSpec.describe Comment, type: :model do
  let!(:user) { User.create(name: 'user_name', email: 'user@email.com', password: 'password') }
  let!(:post_created_by_user) { Post.create(title: 'post_title', description: 'post_content', image: 'nil',user_id: user.id) }
  let!(:comment_created_by_user) { Comment.create(content: 'test') }
  context 'コメントのコンテンツが空の場合' do
    it 'バリデーションにひっかかる' do
      comment = Comment.new(content: nil)
      expect(comment).not_to be_valid
    end
  end
end
