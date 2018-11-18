Rails.application.routes.draw do

#Auth0 routes
 #get 'dashboard/show'
  #get '/dashboard' => 'dashboard#show'
  #get "/auth/oauth2/callback" => "auth0#callback"
  #get "/auth/failure" => "auth0#failure"
  get 'dashboard/show'
  get '/dashboard' => 'dashboard#show'


  post '/create_message' => 'conversations#create_message'
  get '/terms', to: 'static_pages#terms'
  get '/autocomplete_friends', to: 'conversations#autocomplete_friends'

#Twitter callbacks
  match '/auth/twitter/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]
  get "/auth/twitter", as: :twitter_session
  get "/auth/twitter/callback" => "twitter#callback"
  get "/auth/twitter/failure" => "twitter#failure"

  post "/beta_email" => "static_pages#beta_email"

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

  root   'static_pages#landing'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/comingsoon', to: 'static_pages#landing'
  get    '/popular',  to:'wads#popwads'


#Question categories
  get    '/testing',    to:  'discussions#testing'
  get    '/teambuilding',     to:  'discussions#teambuilding'
  get    '/fundraising',     to:  'discussions#fundraising'
  get    '/marketing',     to:  'discussions#marketing'
  get    '/legal',     to:  'discussions#legal'
  get    '/industry',     to:  'discussions#industry'
  get    '/other',     to:  'discussions#other'




#Wad Categories
  get    '/tech',    to:  'wads#tech'
  get    '/b2b',     to:  'wads#b2b'
  get    '/media',     to:  'wads#media'
  get    '/gadgets',     to:  'wads#gadgets'
  get    '/lifestyle',     to:  'wads#lifestyle'
  get    '/innovate',     to:  'wads#innovate'
  get    '/social',     to:  'wads#social'

  get    '/forum',    to:   'discussions#index'



#Defining routes for user profile navigation
  get    '/users/:id/profile_comments', to: 'users#profile_comments', as: :profile_comments
  get    '/users/:id/profile_mail', to: 'users#profile_mail', as: :profile_mail

#Defining routes for search navigation
  get    '/search', to: 'static_pages#search'

  resources :conversations do
    resources :messages
   end

  resources :friends
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :users

  resources :discussions do
    member do
        get "flag", to: "discussions#flag"
        put "like", to: "discussions#upvote"
        put "dislike", to: "discussions#downvote"
        patch :solved
    end
      resources :answers do
        get "flag", to: "answers#flag"
        put "like", to: "answers#upvote"
        put "dislike", to: "answers#downvote"
      end
  end


  resources :wads do
    member do
        post "/add_link", to: "wads#add_link"
        get "flag", to: "wads#flag"
        delete "unflag", to: "wads#unflag"
        put "like", to: "wads#upvote"
        put "dislike", to: "wads#downvote"
        post '/collab', to: 'wads#join'
    end
      resources :comments do
        get "flag", to: "comments#flag"
        put "like", to: "comments#upvote"
        put "dislike", to: "comments#downvote"
      end
  end
end
