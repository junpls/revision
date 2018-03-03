Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles, only: [:show]
  get "articles/*path", to: "articles#show", format: false
  
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
