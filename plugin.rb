# name: csp_violation_tool
# about: CSP Violation Report Tool
# version: 0.0.1

require(File.expand_path("../lib/csp_violation_tool", __FILE__))

Discourse::Application.routes.append do
  mount CspViolationTool::Engine, at: "/csp-violation-tool"
end
