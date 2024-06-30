class MyPagesController < ApplicationController
  def index
    @post = Post.all
  end
end
