Rails.application.routes.draw do
  get 'welcome/index'

  resources :activities
  get 'newsfeed/index'

  #resources :newsfeeds
  resources :comments
  resources :posts
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root ''
end
