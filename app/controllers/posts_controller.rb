class PostsController < ApplicationController
  require 'openai'
  before_action :find_params, only: [:edit, :update, :show, :destroy, :problem]
  before_action :move_to_index, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render action: :edit, status: unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @post.likes.destroy_all
    @post.destroy
    redirect_to root_path
  end

  def problem
    @client = OpenAI::Client.new(api: ENV['OPENAI_API_KEY'])
    @problem = generate_problem(@post.content)
  end

  private

  def find_params
    @post = Post.find(params[:id])
  end

  def move_to_index
    return if current_user.id == @post.user.id

    redirect_to root_path
  end

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
