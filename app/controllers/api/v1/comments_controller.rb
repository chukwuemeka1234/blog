class Api::V1::CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    render json: @comments
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post_id: @post.id, author_id: @user.id, text: params[:text])
    @comment.post_id = @post.id
    respond_to do |format|
      format.json do
        if @comment.save
          render json: { success: true, message: 'Comment was successfully created.' }, status: :ok
        else
          render json: { success: false, message: 'Comment was not created.' }, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
