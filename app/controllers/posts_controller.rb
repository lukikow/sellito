class PostsController < ApplicationController
  def index
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    return unless post_params[:user_id] == current_user.id.to_s
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post created.'
      redirect_to @post
    else
      flash[:alert] = 'Could not create category!'
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)
    if @post.save
      flash[:notice] = 'Post updated.'
      redirect_to @post
    else
      flash[:alert] = 'Post NOT updated.'
      redirect_to @post
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    flash[:notice] = "Post #{@post.title} deleted."
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :expire_date, :user_id)
  end

end
