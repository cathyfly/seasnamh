Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  root to: 'beaches#index'
  resources :beaches
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
