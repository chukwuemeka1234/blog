class Api::V1::PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
    render json: @posts
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(title: params[:title], text: params[:text])
    @post.author_id = @user.id
    respond_to do |format|
      format.json do
        if @post.save
          render json: { success: true, message: 'Post was successfully created.' }, status: :ok
        else
          render json: { success: false, message: 'Post was not created.' }, status: :unprocessable_entity
        end
      end
    end
  end
end