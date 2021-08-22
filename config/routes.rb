Rails.application.routes.draw do
  get '/search', to: "beaches#search"
  get 'reviews/index'
  get 'reviews/show'
  get 'reviews/new'
  get 'reviews/edit'
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  root to: 'beaches#index'
  resources :beaches
  resources :beaches do
    resources :reviews
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
