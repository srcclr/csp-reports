# name: csp-reports
# about: CSP Violations Reporter
# version: 0.0.1

require(File.expand_path("../lib/csp_reports", __FILE__))

after_initialize do
  require(File.expand_path("../app/models/user", __FILE__))
end

Discourse::Application.routes.append do
  mount CspReports::Engine, at: "/csp-reports"
end
