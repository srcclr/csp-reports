module CspReports
  class EmailNotification < ActiveRecord::Base
    belongs_to :domain, foreign_key: "csp_reports_domain_id"
    belongs_to :user
  end
end
