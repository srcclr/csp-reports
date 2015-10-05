CspViolationTool::Engine.routes.draw do
  resources :reports, only: :index

  root to: "reports#index"
end
