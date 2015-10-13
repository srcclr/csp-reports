module CspReports
  class DomainsController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr
    before_action :generate_report_uri_hash

    respond_to :html, :json

    def create
      domain = Domain.create!(domain_params.merge(user_id: current_user.id))
      render json: domain
    end

    def index
      respond_to do |format|
        format.html do
          store_preloaded("domains", MultiJson.dump(user_with_domains))
          render "default/empty"
        end

        format.json { render json: user_with_domains }
      end
    end

    def show
      respond_to do |format|
        format.html do
          store_preloaded("domain", MultiJson.dump(domain_as_json))
          render "default/empty"
        end

        format.json { render json: domain_as_json }
      end
    end

    private

    def domain_params
      params.require(:domain).permit(:name, :url)
    end

    def domain_as_json
      serialize_data(Domain.find(params[:id]), DomainWithReportsSerializer, root: false)
    end

    def user_with_domains
      serialize_data(
        current_user,
        UserWithDomainsSerializer,
        root: false,
        host: request.base_url
      )
    end

    def generate_report_uri_hash
      current_user.generate_report_uri_hash unless current_user.report_uri_hash
    end
  end
end