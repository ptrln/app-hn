HackerClone::Application.routes.draw do

	resource :users, :only => [:new, :create, :show]
	resource :posts, :only => [:new, :index, :create, :show] do
		resource :comments, :only => [:new, :index, :create]
		resource :post_votes, :only => [:create, :destroy]
	end
	resource :comments, :only => [:show] do
		resource :comment_votes, :only => [:create, :destroy]
	end
end
