FamilyFeudWeb::Application.routes.draw do
  resources :games, :only => [ :show, :create ]

  post "messages/received"

  root :to => 'welcome#index'
end
