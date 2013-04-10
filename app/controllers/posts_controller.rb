class PostsController < ApplicationController
	include PostVotesHelper

	before_filter :require_login, only: [:new, :create]

  def index
		@posts = Post.top.page(params[:page])
  end

	def newest
		@posts = Post.newest.page(params[:page])
		render :index
	end

	def new
		@post = Post.new
		@post.comments.build
  end

  def create
		@post = current_user.posts.build(params[:post])
		if @post.comments.first
			@post.comments.first.user_id = current_user.id
			@post.comments.first.nesting = "|0"
		end
		if @post.save
			upvote(@post.id)
			redirect_to @post
		else
			render :new
		end
  end

  def show
		@post = Post.find(params[:id])
		@comment = Comment.new
  end
end
