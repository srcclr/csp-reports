# Configure Rails Environment
require "spec_helper"
require "rspec/rails"

ActiveRecord::Migrator.migrations_paths << File.expand_path("../../db/migrate", __FILE__)

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
end
