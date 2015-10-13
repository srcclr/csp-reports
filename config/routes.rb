CspReports::Engine.routes.draw do
  resources :domains, only: %i(index create show)

  root to: "domains#index"
end
