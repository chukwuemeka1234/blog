class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments
  end
end
