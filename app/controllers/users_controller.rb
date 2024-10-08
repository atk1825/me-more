class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @posts = current_user.posts.order(created_at: :desc)
    @yesterday_posts = current_user.posts.yesterday(current_user.id).order(created_at: :desc)
    @three_days_later_posts = current_user.posts.three_days_later(current_user.id).order(created_at: :desc)
    @seven_days_later_posts = current_user.posts.seven_days_later(current_user.id).order(created_at: :desc)
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
