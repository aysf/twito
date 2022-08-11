# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  
  get '/', to: "home#top"
  get '/about', to: "home#about"
  
  # post
  get '/posts', to: "posts#index"
  post '/posts/create', to: "posts#create"
  
  # users
  get "/users/index", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:id/likes", to: "users#likes"
  get "/users/:id/edit", to: "users#edit"
  post "/users/:id/update", to: "users#update"

  # user auth
  get "/signup", to: "users#new"
  get "/login", to: "users#login_form"
  post "/signup", to: "users#create" 
  post "/login", to: "users#login"
  post "/logout", to: "users#logout"
  get "/logout", to: "users#tes"

  # likes
  post "/likes/:post_id/create", to: "likes#create"
  post "/likes/:post_id/destroy", to: "likes#destroy"

end
