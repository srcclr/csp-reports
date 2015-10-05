CspViolationTool::Engine.routes.draw do
  resource :reports, only: :index

  root to: "reports#index"
end
