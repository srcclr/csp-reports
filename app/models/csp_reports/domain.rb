module CspReports
  class Domain < ActiveRecord::Base
    has_many :reports
  end
end
