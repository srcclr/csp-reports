CspReports::Engine.routes.draw do
  resources :domains, only: %i(index create show destroy) do
    resources :reports, only: :index
    resources :viewers, only: %i(index create destroy)
    resource :email_notifications, only: :update
  end

  get "domains/:domain_id/graph", to: "reports#index"

  root to: "domains#index"
end

Rails.application.routes.draw do
  post "/report-uri/:report_uri_hash", to: "csp_reports/reports#create"
end
