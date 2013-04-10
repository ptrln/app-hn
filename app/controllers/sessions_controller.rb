class SessionsController < ApplicationController
  def new
  end

  def create
		user = User.find_by_screen_name(params[:screen_name])
		if user && user.password ==  params[:password]
			sign_in(user)
			redirect_to posts_url
		else
			render :new
		end
  end

  def destroy
		sign_out
		redirect_to posts_url
  end
end
