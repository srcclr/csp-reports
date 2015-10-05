# name: csp_violation_tool
# about: CSP Violation Report Tool
# version: 0.0.1

require(File.expand_path("../lib/csp_violation_tool", __FILE__))

after_initialize do
  require(File.expand_path('../app/models/user', __FILE__))
end

Discourse::Application.routes.append do
  mount CspViolationTool::Engine, at: "/csp-violation-tool"
end
