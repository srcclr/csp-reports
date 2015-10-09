CspReports::Engine.routes.draw do
  resources :domains, only: %i(index create)

  root to: "domains#index"
end
