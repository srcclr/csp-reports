Rails.application.routes.draw do

  mount CspViolationTool::Engine => "/csp_violation_tool"
end
