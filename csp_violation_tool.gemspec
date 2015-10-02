$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "csp_violation_tool/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "csp_violation_tool"
  s.version     = CspViolationTool::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CspViolationTool."
  s.description = "TODO: Description of CspViolationTool."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
