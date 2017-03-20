Rails.application.routes.draw do
  resources :bookmarks do
    get :autocomplete_tag_name, on: :collection
  end

  root to: "bookmarks#index"

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get "/signup" => "users#new"
  post "/users" => "users#create"
end
