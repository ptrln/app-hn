HackerClone::Application.routes.draw do
	resource :session, :only => [:new, :create, :destroy]

	resources :users, :only => [:new, :create, :show]
	resources :posts, :only => [:new, :index, :create, :show] do
		resources :comments, :only => [:create]
		resource :post_votes, :only => [:create, :destroy]
	end
	resources :comments, :only => [:show] do
		resource :comment_votes, :only => [:create, :destroy]
		resources :comments, :only => [:create]
	end

	root to: "posts#index"
end
