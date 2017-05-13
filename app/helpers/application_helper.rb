module ApplicationHelper

  def current_user_is_admin
    current_user && current_user.is_admin?
  end

  def login_user_link
    link_to 'Login', new_user_session_path
  end

  def logout_user_link
    link_to 'Logout', destroy_user_session_path, method: :delete
  end

  def log_in_out_user_link
    current_user ? logout_user_link : login_user_link
  end

  def admin_categories_link
    categories_link_Tag = "<li>#{link_to 'Categories', categories_path}</li>"
    categories_link_Tag.html_safe if current_user_is_admin
  end

  def user_posts_link
    link_to 'Posts', posts_path
  end

end
