module CspReports
  class ViewersController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr

    before_action :ensure_logged_in
    before_action :authorize_user!

    respond_to :html, :json

    def index
      respond_to do |format|
        format.html do
          store_preloaded("viewers", MultiJson.dump(viewers_as_json))
          render "default/empty"
        end

        format.json { render json: viewers_as_json }
      end
    end

    def create
      shared_domain = domain.shared_domains.create(user_id: params[:user_id])
      Jobs.enqueue(:shared_domain, user_id: params[:user_id], domain_id: domain.id)
      render json: serialize_data(shared_domain.user, ViewerSerializer)
    end

    def destroy
      status = shared_domain.try(:destroy) ? :ok : :not_found
      head status
    end

    private

    def authorize_user!
      head :unauthorized unless domain.user == current_user
    end

    def domain
      @domain ||= Domain.find(params[:domain_id])
    end

    def shared_domain
      @shared_domain ||= domain.shared_domains.find_by_user_id(params[:id])
    end

    def viewers_as_json
      serialize_data(domain, DomainViewersSerializer, root: false)
    end
  end
end
