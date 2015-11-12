module CspReports
  class SharedDomain < ActiveRecord::Base
    belongs_to :domain
    belongs_to :user
  end
end
