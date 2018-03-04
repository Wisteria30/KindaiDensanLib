Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get '/' => "book#index"
  get '/search' => "book#search"
  get '/wantBook' => "book#wantBook"
  post '/url' => "book#url"
  get '/inquiry' => "book#inquiry"
  get '/help' => "book#help"
  get '/:id' => "book#show"
  post '/:id/rental' => "book#rental"
  get '/:id/user' => "book#user"
  post '/:id/return' => "book#return"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
