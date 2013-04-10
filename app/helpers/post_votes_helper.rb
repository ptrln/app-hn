module PostVotesHelper
	MINIMUM_UPVOTE_KARMA = 0	#want users to immediately upvote (for demo)

	def has_upvoted?(post_id)
		PostVote.where(post_id: post_id, user_id: current_user.id).count > 0
	end

	def upvote(post_id)
		PostVote.create(post_id: post_id, user_id: current_user.id)
	end

	def has_enough_karma
		unless @current_user.karma >= MINIMUM_UPVOTE_KARMA
			flash[:info] = "You do not have enough karma to do that!"
			redirect_to :back
		end
	end
end
