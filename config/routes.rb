Rails.application.routes.draw do

  get 'sessions/new'

  get 'users/new'

  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/industries', to: 'industries#index'
  get    '/music',    to:  'industries#music'
  get    '/tech',     to:  'industries#tech'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
#Defining routes for user profile navigation

  get    '/users/:id/profile_comments', to: 'users#profile_comments', as: :profile_comments
  get    '/users/:id/profile_mail', to: 'users#profile_mail', as: :profile_mail


  resources :users 
  resources :wads do
    member do
        put "like", to: "wads#upvote"
    end
      resources :comments do 
        put "like", to: "comments#upvote"
      end   
    end
end
