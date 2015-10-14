CspReports::Engine.routes.draw do
  resources :domains, only: %i(index create show)

  root to: "domains#index"

  post "/report-uri/:report_uri_hash", to: "reports#create"
end
