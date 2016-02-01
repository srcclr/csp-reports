module CspReports
  class Report < ActiveRecord::Base
    belongs_to :domain, foreign_key: "csp_reports_domain_id"

    scope :recent, -> { order(created_at: :desc) }

    def self.for_type(type)
      case type
      when "daily" then
        where("DATE(created_at) = ?", Date.yesterday)
      when "weekly" then
        prev_week = Date.current.prev_week
        where("DATE(created_at) >= ? AND DATE(created_at) <= ?", prev_week, prev_week + 6.days)
      when "monthly" then
        where("DATE_PART('month', created_at) = ?", Date.current.prev_month.month)
      else
        none
      end
    end
  end
end
