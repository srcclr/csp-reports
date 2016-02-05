module CspReports
  class ReportsController < ::ApplicationController
    skip_before_action :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    before_action :find_user!, :verify_domain!, only: :create

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    def index
      serialized = serialize_data(paginated_reports, ReportSerializer, root: "reports", meta: meta)

      respond_to do |format|
        format.html do
          store_preloaded("reports", MultiJson.dump(serialized))
          render "default/empty"
        end

        format.json { render json: serialized }
      end
    end

    def graph
      serialized = serialize_data(reports, ReportSerializer, root: "reports")

      respond_to do |format|
        format.html do
          store_preloaded("reports", MultiJson.dump(serialized))
          render "default/empty"
        end

        format.json { render json: serialized }
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
      @reports ||= ReportsQueryObject.new(params[:domain_id], params.slice(:all, :from, :to, :sort)).all
    end

    def paginated_reports
      reports.limit(per).offset((page - 1) * per)
    end

    def meta
      {
        total: reports.count,
        page: page,
        per: per
      }
    end

    def page
      (params[:page] || 1).to_i
    end

    def per
      (params[:per] || 25).to_i
    end
  end
end
