module CspReports
  class Domain < ActiveRecord::Base
    belongs_to :user

    has_many :reports, foreign_key: "csp_reports_domain_id", dependent: :destroy
    has_many :shared_domains, foreign_key: "csp_reports_domain_id", dependent: :destroy
    has_many :viewers, through: :shared_domains, source: :user

    def candidate_viewers
      User.where.not(id: viewers.pluck(:id))
    end
  end
end
