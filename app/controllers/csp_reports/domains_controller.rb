module CspReports
  class DomainsController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr

    before_action :ensure_logged_in
    before_action :generate_report_uri_hash

    respond_to :html, :json

    serialization_scope :view_context

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

    def destroy
      status = domain && domain.destroy ? :ok : :not_found

      head status
    end

    rescue_from Discourse::NotLoggedIn do
      if (request.format && request.format.json?) || request.xhr? || !request.get?
        render json: {}
      else
        redirect_to path("/projects/csp-reports")
      end
    end

    private

    def domain
      @domain ||= current_user.domains.find_by_id(params[:id]) || current_user.friend_domains.find_by_id(params[:id])
    end

    def domain_params
      params.require(:domain).permit(:name, :url)
    end

    def domain_as_json
      serialize_data(
        domain,
        DomainSerializer,
        root: false
      )
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
