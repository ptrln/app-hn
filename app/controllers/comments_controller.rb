class CommentsController < ApplicationController
  before_filter :require_login, only: [:create]

	def newest
		@comments = Comment.newest.all
		render :index
	end

	def show
		@comment = Comment.find(params[:id])
		@comment_new = Comment.new
		@children = Comment.where(
			'post_id = ? AND nesting LIKE ? AND id != ?',
			@comment.post_id,
			"#{@comment.nesting}%",
			@comment.id
		)
  end

	def build_nesting(count)
		"#{"|" * count.to_s.length}#{count}"
	end

  def create
		post_comment_count = Comment.where(post_id: params[:post_id], parent_id: nil).count
		if params[:post_id]
			@comment = Comment.new(
				post_id: params[:post_id],
				body: params[:comment][:body],
				user_id: current_user.id,
				nesting: build_nesting(post_comment_count)
			)
			if @comment.save
				redirect_to @comment
			else
				@post = Post.find(params[:post_id])
				render "posts/show"
			end
		elsif params[:comment_id]
			parent = Comment.find(params[:comment_id])
			@comment = Comment.new(
				post_id: parent.post_id,
				body: params[:comment][:body],
				user_id: current_user.id,
				nesting: parent.nesting + build_nesting(parent.comments.count),
				parent_id: parent.id
			)
			if @comment.save
				redirect_to @comment
			else
				@post = Post.find(params[:post_id])
				render "posts/show"
			end

		end
  end
end
