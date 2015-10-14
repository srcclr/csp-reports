# name: csp-reports
# about: CSP Violations Reporter
# version: 0.0.1

require(File.expand_path("../lib/csp_reports", __FILE__))

Discourse::Application.routes.append do
  mount CspReports::Engine, at: "/csp-reports"
end
