

class PostsController < ApplicationController
  include Authorization
  before_action :set_post, only: %i[show update destroy]
  before_action :authorize_post!, only: %i[update destroy]

  def index
    posts = Post.all
    render json: posts
  end

  def show
    render json: {
      post: @post,
      tags: @post.tags,
      comments: @post.comments.order(created_at: :desc)
    }
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      DeletePostWorker.perform_in(24.hours, post.id)
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render json: { message: 'Post was successfully deleted.' }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post!
    authorize_owner!(@post)
  end

  def post_params
    params.require(:post).permit(:title, :body, tag_ids: [])
  end
end
