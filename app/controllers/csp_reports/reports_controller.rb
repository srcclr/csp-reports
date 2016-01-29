module CspReports
  class ReportsController < ::ApplicationController
    skip_before_action :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    before_action :find_user!, :verify_domain!, only: :create

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    def index
      respond_to do |format|
        format.html do
          store_preloaded("reports", MultiJson.dump(reports_as_json))
          render "default/empty"
        end

        format.json { render json: reports_as_json }
      end
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
      @domain = @user.domains.with_url(referrer_domain).first

      head :unauthorized if @domain.blank?
    end

    def referrer_domain
      referrer_uri = URI(request.referrer)
      "#{referrer_uri.scheme}://#{referrer_uri.host}"
    end

    def parsed_report
      JSON.parse(request.raw_post)
    end

    def reports
      reports = Report.where(csp_reports_domain_id: params[:domain_id]).recent
      reports = reports.where(created_at: filter_range) if filter_range
      reports
    end

    def reports_as_json
      serialize_data(reports, ReportSerializer)
    end

    def filter_range
      Range.new(params[:from], params[:to]) if [params[:from], params[:to]].all?
    end
  end
end
