class UsersController < ApplicationController
  before_action :authenticate_user! 

  def index
    @posts = current_user.posts
    @users = User.all
    if user_signed_in?
      likes(current_user)
    else
      @like_posts = Post.none
    end
  end

  private

  def likes(user)
    likes = Like.where(user_id: user.id).pluck(:post_id)
    @like_posts = Post.where(id: likes)
  end
end
