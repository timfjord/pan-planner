PanPlanner::Application.routes.draw do
  resources :users

  resources :events

  root :to => 'events#index'
end
