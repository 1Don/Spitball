Rails.application.routes.draw do

  get 'sessions/new'

  get 'users/new'

  root   'static_pages#landing'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/comingsoon',  to: 'static_pages#landing'

#Defining routes for industry navigation
  get '/industries', to: 'industries#index'
  get    '/art',    to:  'industries#art'
  get    '/b2bsaas',     to:  'industries#b2bsaas'
  get    '/finance',     to:  'industries#finance'
  get    '/manufacturing',     to:  'industries#manufacturing'
  get    '/smallbusiness',     to:  'industries#smallbusiness'
  get    '/consumertech',     to:  'industries#consumertech'
  get    '/other',     to:  'industries#other'


#Defining routes for discussion/forum navigation
  resources :discussions do
    member do
      put "like", to: "discussions#upvote"
    end
  end
  get    '/forum',    to:   'discussions#index'



#Defining routes for user profile navigation
    get    '/users/:id/profile_comments', to: 'users#profile_comments', as: :profile_comments
    get    '/users/:id/profile_mail', to: 'users#profile_mail', as: :profile_mail

#Defining routes for search navigation
    get    '/search', to: 'wads#search'

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
