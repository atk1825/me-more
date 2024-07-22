class PostsController < ApplicationController
  require 'openai'

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
    @problem = generate_problem(@post.content)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.likes.destroy_all
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :genre_id, :image).merge(user_id: current_user.id)
  end

  def generate_problem(content)
    client = OpenAI::Client.new(api_key: ENV['OPENAI_API_KEY'])
    response = client.completions(
      parameters: {
        model: 'gpt-3.5',
        messages: [
          { role: 'system', content: 'You are a helpful assistant.' },
          { role: 'user', content: "Generate a problem based on the following content: #{content}" }
        ],
        max_tokens: 100
      }
    )
    response.dig('choices', 0, 'message', 'content').strip
  end
end
