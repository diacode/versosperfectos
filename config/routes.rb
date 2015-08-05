Vp4::Application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # Legacy routes
  # =============
  get 'discos/-/:permalink', to: redirect{|params, req| "/discos/#{params[:permalink]}"}
  get 'autores/-/:permalink', to: redirect{|params, req| "/autores/#{params[:permalink]}"}
  get 'canciones/-/:permalink', to: redirect{|params, req| "/canciones/#{params[:permalink]}"}

  # Public routes
  # =============
  root :to => "home#index"

  # TODO: Meter estas rutas dentro de resources :posts
  match "noticias/categoria/:slug" => "posts#index", :via => :get, :as => :posts_by_category
  match "noticias/tag/:slug" => "posts#index", :via => :get, :as => :posts_by_tag
  match "noticias/:year/:month" => "posts#indx", :via => :get, :as => :posts_by_date
  match "noticias/:year/:month/:slug" => "posts#show", :via => :get, :as => :post_extended
  
  resources :posts, path: "noticias", only: [:index] do
    get 'feed', on: :collection
    resources :comments, :only => [:create]
  end

  resources :artists, path: 'autores', :only => [:index, :show] do
    post "like", on: :member
  end

  resources :albums, path: 'discos', only: [:index, :show] do
    resources :reviews, only: [:show]
    post "vote", on: :member
    post "like", on: :member
    get "releases", on: :collection, path: 'lanzamientos'
  end

  resources :songs, path: 'canciones', only: [:show] do
    get 'spotify_player', on: :member
  end

  resources :punchlines, only: [:index, :show] do
    get 'stream/:song_id', to: "punchlines#stream", as: :song_stream, on: :member
    get 'download/:song_id', to: "punchlines#download", as: :song_download, on: :member
    get 'download_package', to: "punchlines#download_package", on: :member
    get 'list/:order', to: "punchlines#list", on: :collection, as: :list
  end

  resources :profiles, path: 'perfiles', only: [:show] do
    get 'liked_artists', on: :member
    get 'liked_albums', on: :member
    get 'liked_songs', on: :member
    get 'ratings', on: :member
    get 'lyrics_sent', on: :member
  end

  resource :account, path: 'cuenta', only: [:edit, :update] do
    get 'connections', on: :member
  end
  
  # Searching routes
  get 'search/posts'

  # Admin routes
  # ============
  namespace :admin do
    root :to => "dashboard#index"

    match 'dashboard' => "dashboard#index"
    match 'dashboard/index' => "dashboard#index"
    match "songs/search" => "songs#search", :via => [:get]
    match 'posts/tags' => "posts#tags"
    match 'artists/upload_picture' => "artists#upload_picture", :via => [:post]
    resources :featured_blocks
    resources :posts do 
      get 'search', on: :collection
    end
    resources :artists do 
      get 'twitter_lookup', on: :collection
      get 'aliases', on: :member
    end
    resources :albums do
      post 'massive_association', on: :collection
    end
    resources :record_labels
    resources :songs
    resources :tracks
    resources :banners
    resources :users, except: [:new, :create, :destroy]
    resources :task_logs, only: [:index, :show]
    resources :punchlines, except: [:new] do
      post 'upload_file', on: :member
      post 'upload_artwork', on: :member
      post 'generate_package', on: :member
      put 'feature', on: :member
      delete 'destroy_artwork', on: :member
      delete 'destroy_song_file', on: :member
      get 'package_status', on: :member
    end
  end
end
