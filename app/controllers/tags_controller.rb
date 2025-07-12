
class TagsController < ApplicationController
  def index
    tags = Tag.all
    render json: tags
  end

  def show
    tag = Tag.find(params[:id])
    render json: { tag: tag, posts: tag.posts }
  end
end
