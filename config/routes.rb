Whois::Application.routes.draw do
  resources :queries, only: [:new, :create]
  match '/queries', to: 'queries#new'
  root :to => 'queries#new'
end
