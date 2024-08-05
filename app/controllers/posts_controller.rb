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
  end

  def destroy
    @post = Post.find(params[:id])
    @post.likes.destroy_all
    @post.destroy
    redirect_to root_path
  end

  def problem
    @post = Post.find(params[:id])
    @client = OpenAI::Client.new(api: ENV['OPENAI_API_KEY'])
    @problem = generate_problem(@post.content)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :genre_id, :image).merge(user_id: current_user.id)
  end

  def generate_problem(content)
    response = @client.chat(parameters: {
                              model: 'gpt-3.5-turbo',
                              messages: [
                                { role: 'system', content: '現在記憶の定着のために勉強中です' },
                                { role: 'user',
                                  content: "以下の内容が答えになるように情報を２つ補足して問題を作ってください #{content}" }
                              ],
                              max_tokens: 500
                            })
    if response['choices'] && response['choices'][0] && response['choices'][0]['message'] && response['choices'][0]['message']['content']
      response.dig('choices', 0, 'message', 'content').strip
    else
      'Error generating problem'
    end
  rescue StandardError => e
    Rails.logger.error("OpenAI API Error: #{e.message}")
    'Error generating problem'
  end
end
