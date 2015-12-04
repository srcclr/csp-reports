module CspReports
  class EmailNotification < ActiveRecord::Base
    NOTIFICATION_TYPES = %w(never daily weekly monthly)

    belongs_to :domain, foreign_key: "csp_reports_domain_id"
    belongs_to :user

    scope :for_type, -> (type) { where(notification_type: type) }
  end
end
