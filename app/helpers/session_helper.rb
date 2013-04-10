module SessionHelper

	def require_login
		unless signed_in?
			flash[:info] = "You need to log in to do that!"
			redirect_to new_session_url
		end
	end

	def current_user
		return nil unless session[:user_id]
		@current_user ||= User.find(session[:user_id])
	end

	def current_user=(user)
		@current_user = user
	end

	def sign_in(user)
		session[:user_id] = user.id
		self.current_user = user
	end

	def sign_out
		session[:user_id] = nil
	end

	def signed_in?
		!current_user.nil?
	end
end
