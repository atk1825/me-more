class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path(@post)
    else
      render action: :new, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :genre_id).merge(user_id: current_user.id)
  end
end
