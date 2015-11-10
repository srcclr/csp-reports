module CspReports
  class ReportsController < ::ApplicationController
    skip_before_action :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    before_action :find_user!, :verify_domain!

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    def create
      @domain.reports.create(result: parsed_report["csp-report"])

      head :created
    end

    private

    def find_user!
      @user = User.find_by_report_uri_hash!(params["report_uri_hash"])
    end

    def verify_domain!
      domain_name = URI(request.referrer).host
      @domain = @user.domains.find_by_url(domain_name)

      head :unauthorized if @domain.blank?
    end

    def parsed_report
      JSON.parse(request.raw_post)
    end
  end
end
