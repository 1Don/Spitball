Rails.application.routes.draw do

  get 'friends/index'

  get 'friends/destroy'

  resources :friend_requests
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
  get    '/comingsoon',  to: 'static_pages#landing'
  get    '/popular',  to:'wads#popwads'
  

  get    '/tech',    to:  'wads#consumertech'
  get    '/b2b',     to:  'wads#b2b'
  get    '/product',     to:  'wads#product'
  get    '/social',     to:  'wads#social'
  get    '/local',     to:  'wads#local'
  get    '/events',     to:  'wads#events'
  get    '/innovate',     to:  'wads#innovate'
  get    '/media',     to:  'wads#media'

  get    '/forum',    to:   'discussions#index'



#Defining routes for user profile navigation
    get    '/users/:id/profile_comments', to: 'users#profile_comments', as: :profile_comments
    get    '/users/:id/profile_mail', to: 'users#profile_mail', as: :profile_mail

#Defining routes for search navigation
    get    '/search', to: 'wads#search'


  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  
  resources :users 

  resources :discussions do
    member do
        put "like", to: "discussions#upvote"
        patch :solved
    end
      resources :answers do 
        put "like", to: "answers#upvote"
      end   
  end


  resources :wads do
    member do
        put "like", to: "wads#upvote"
    end
      resources :comments do 
        put "like", to: "comments#upvote"
      end   
  end
end
