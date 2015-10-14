module CspReports
  class Report < ActiveRecord::Base
    belongs_to :domain
  end
end
