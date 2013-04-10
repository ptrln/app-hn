module SessionHelper

	def require_login
		redirect_to new_session_url unless signed_in?
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
