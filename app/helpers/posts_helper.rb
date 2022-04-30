# frozen_string_literal: true

module PostsHelper
  def choose_new_or_edit
    case action_name
    when 'new', 'create'
      confirm_posts_path
    when 'edit'
      post_path
    end
  end
  #  def change_css
  #     cnt=current_user.posts.size % 5
  #     %w[lightgrey lightblue orange green red][cnt]
  #  end
end
