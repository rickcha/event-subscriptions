class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show
    @post = Post.find(params[:id])
  end
  
  def new
    if session[:user_id] == nil
      flash[:warning] = "You must login before creating a post"
      redirect_to '/login'
    end
    @post = Post.new
  end

	def edit
	end

	def create
    @post = Post.new(post_params)
   
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

	def update
	end

	def destroy
	end

	private
    def post_params
      params.require(:post).permit(:title, :text).merge(user_id: current_user.id)
    end
end
