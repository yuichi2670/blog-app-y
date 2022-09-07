Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'articles#index'
  # onlyは機能をしてするときに使うものなので、基本的な機能全て使うときはいらない
  resources :articles do
    resources :comments, only: [:new, :create]
  end
end
