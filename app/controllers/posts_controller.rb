class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]

	def index
		@posts = Post.order(created_at: :desc)
	end

	def new
		@post = Post.new
	end

	def show
  @post = Post.find(params[:id])
	end

	def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end


	private
	def post_params
  	params.require(:post).permit(:title, :body)
	end
end
