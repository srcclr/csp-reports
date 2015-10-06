$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "csp_reports/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "csp-reports"
  s.version     = CspReports::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CspReports."
  s.description = "TODO: Description of CspReports."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rubocop"
end
