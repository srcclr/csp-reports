module CspReports
  class ReportsController < ::ApplicationController
    skip_before_action :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    before_action :verify_user_domain

    def create
      @domain.reports.create(result: params["csp-report"])

      head :created
    end

    private

    def verify_user_domain
      @user = User.find_by_report_uri_hash!(params["report_uri_hash"])
      @domain = @user.domains.find_by_url!(params["csp-report"]["referrer"])
    end
  end
end
