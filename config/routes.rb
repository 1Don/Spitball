Rails.application.routes.draw do

  root 'static_pages#home'
  get '/help',  to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'
  get '/contact',  to: 'static_pages#contact'
  get 'sessions/new'
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/contact'
  get 'users/new'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :wads do
  	member do
  		put 'like', to: 'wads#upvote'
  	end
  	resources :comments
  		put 'like', to: 'comments#upvote'
  end
end
