class PostVotesController < ApplicationController
	include PostVotesHelper

	before_filter :require_login, :has_enough_karma

	def create
		upvote(params[:post_id]) unless has_upvoted?(params[:post_id])
		redirect_to :back
  end

  def destroy
		PostVote.where(post_id: params[:post_id], user_id: current_user.id).destroy_all
		redirect_to :back
  end
end
