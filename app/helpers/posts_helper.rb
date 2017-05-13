module PostsHelper
  def post_owner(post)
    current_user && post.user_id == current_user.id
  end

  def user_posts_link
    link_to 'My posts', my_posts_path
  end
end
