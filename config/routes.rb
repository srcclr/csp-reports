CspReports::Engine.routes.draw do
  resources :domains, only: %i(index create show destroy)

  root to: "domains#index"
end

Rails.application.routes.draw do
  post "/report-uri/:report_uri_hash", to: "csp_reports/reports#create"
end
