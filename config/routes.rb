FamilyFeudWeb::Application.routes.draw do
  get "games/create"
  match "/games/:id" => "games#show"

  post "messages/received"

  root :to => 'welcome#index'
end
