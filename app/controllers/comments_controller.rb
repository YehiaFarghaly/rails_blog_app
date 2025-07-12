
class CommentsController < ApplicationController
  include Authorization
  before_action :set_post
  before_action :set_comment, only: %i[update destroy]
  before_action :authorize_comment, only: %i[update destroy]

  def create
    comment = @post.comments.build(comment_params.merge(user: current_user))
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: { message: 'Comment was successfully destroyed.' }
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end


  def authorize_comment
    authorize_owner!(@comment)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
