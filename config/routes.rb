FamilyFeudWeb::Application.routes.draw do
  get "state/advance"

  get "pusher/received"

  get "games/create"
  match "/games/:id" => "games#show"

  post "messages/received"

  root :to => 'welcome#index'
end
