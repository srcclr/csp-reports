module CspReports
  class DomainsController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr
    before_action :generate_report_uri_hash

    def create
      domain = Domain.create!(domain_params.merge(user_id: current_user.id))
      render json: domain
    end

    def index
      respond_to do |format|
        format.json { render json: user_with_domains }
        format.html do
          store_preloaded("domains", MultiJson.dump(user_with_domains))
          render "default/empty"
        end
      end
    end

    private

    def domain_params
      params.require(:domain).permit(:name, :url)
    end

    def user_with_domains
      serialize_data(current_user, UserWithDomainsSerializer, root: false)
    end

    def generate_report_uri_hash
      current_user.generate_report_uri_hash unless current_user.report_uri_hash
    end
  end
end
