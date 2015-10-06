module CspReports
  class ReportsController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr
    before_action :generate_report_uri_hash
    respond_to :html, :json

    def index
      respond_to do |format|
        format.json { render json: data }
        format.html do
          store_preloaded("reports", MultiJson.dump(data))
          render "default/empty"
        end
      end
    end

    private

    def generate_report_uri_hash
      current_user.generate_report_uri_hash unless current_user.report_uri_hash
    end

    def data
      { report_uri: report_uri }
    end

    def report_uri
      "#{request.base_url}/report-uri/#{current_user.report_uri_hash}"
    end
  end
end
