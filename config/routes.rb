Rails.application.routes.draw do

#Auth0 routes
 #get 'dashboard/show'
  #get '/dashboard' => 'dashboard#show'
  #get "/auth/oauth2/callback" => "auth0#callback"
  #get "/auth/failure" => "auth0#failure"
  get 'dashboard/show'
  get '/dashboard' => 'dashboard#show'


#Twitter callbacks
  match '/auth/twitter/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]
  get "/auth/twitter", as: :twitter_session
  get "/auth/twitter/callback" => "twitter#callback"
  get "/auth/twitter/failure" => "twitter#failure"



  # Linkedin callbacks
  match '/auth/linkedin/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]
  get "/auth/linkedin", as: :linkedin_session
  get "/auth/linkedin/callback" => "linkedin#callback"
  get "/auth/linkedin/failure" => "linkedin#failure"

  

  # Google oauth2 callbacks
  match '/auth/google_oauth2/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]
  get "/auth/google_oauth2", as: :google_session
  get "/auth/google_oauth2/callback" => "google_oauth2#callback"
  get "/auth/google_oauth2/failure" => "google_oauth2#failure"


  #get 'auth/:provider/callback', to: 'sessions#create'
  #get 'auth/failure', to: redirect('/')
  #get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create, :destroy]

  #friendship routes

  resources :friend_requests
  get 'friendships/create'

  get 'friendships/destroy'

  get 'sessions/new'

  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/comingsoon', to: 'static_pages#landing'
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
    get    '/search', to: 'static_pages#search'

  resources :conversations do
    resources :messages
   end


  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :users

  resources :discussions do
    member do
        put "like", to: "discussions#upvote"
        put "dislike", to: "discussions#downvote"
        patch :solved
    end
      resources :answers do
        put "like", to: "answers#upvote"
        put "dislike", to: "answers#downvote"
      end
  end


  resources :wads do
    member do
        put "like", to: "wads#upvote"
        put "dislike", to: "wads#downvote"
    end
      resources :comments do
        put "like", to: "comments#upvote"
        put "dislike", to: "comments#downvote"
      end
  end
end
