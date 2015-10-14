module CspReports
  class ReportsController < ::ApplicationController
    skip_before_action :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    before_action :find_user!, :verify_domain!

    def create
      @domain.reports.create(result: params["csp-report"])

      head :created
    end

    private

    def find_user!
      @user = User.find_by_report_uri_hash!(params["report_uri_hash"])
    end

    def verify_domain!
      @domain = @user.domains.find_by_url(request.referrer)
      head :unauthorized if @domain.blank?
    end
  end
end
