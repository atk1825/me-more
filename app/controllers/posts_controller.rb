class PostsController < ApplicationController
  require 'openai'

  def initialize # rubocop:disable Lint/MissingSuper
    @client = OpenAI::Client.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path(@post)
    else
      render action: :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @problem = generate_problem(@post.detail)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.likes.destroy_all
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :detail, :genre_id, :image).merge(user_id: current_user.id)
  end

  def generate_problem(detail)
    response = @client.chat(parameters: {
                              model: 'gpt-3.5-turbo',
                              messages: [
                                { role: 'system', content: 'You are a helpful assistant.' },
                                { role: 'user', content: "Generate a problem based on the following content: #{detail}" }
                              ],
                              max_tokens: 100
                            })
    response.dig('choices', 0, 'message', 'content').strip
  end
end
