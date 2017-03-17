Rails.application.routes.draw do
  resources :bookmarks
  root to: "bookmarks#index"

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get "/signup" => "users#new"
  post "/users" => "users#create"
end
