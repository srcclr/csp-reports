CspReports::Engine.routes.draw do
  resources :domains, only: %i(index create show destroy) do
    resources :viewers, only: %i(create destroy)
    resource :email_notifications, only: %i(update destroy)
  end

  root to: "domains#index"
end

Rails.application.routes.draw do
  post "/report-uri/:report_uri_hash", to: "csp_reports/reports#create"
end
