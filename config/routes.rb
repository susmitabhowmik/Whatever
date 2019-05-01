Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end

  namespace :api do
    get '/restaurants' => 'restaurants#index'

    get '/events' => 'events#index'

    post '/users' => 'users#create'

    get '/events2' => 'events2#index'

    post '/sessions' => 'sessions#create'
  end
end
