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
  get    '/art',    to:  'industries#art'
  get    '/b2bsaas',     to:  'industries#b2bsaas'
  get    '/finance',     to:  'industries#finance'
  get    '/manufacturing',     to:  'industries#manufacturing'
  get    '/smallbusiness',     to:  'industries#smallbusiness'
  get    '/consumertech',     to:  'industries#consumertech'
  get    '/other',     to:  'industries#other'


  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
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
