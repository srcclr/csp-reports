module CspReports
  class ViewersController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr

    before_action :ensure_logged_in

    respond_to :html, :json

    def create
      shared_domain = domain.shared_domains.create(user_id: params[:user_id])
      render json: serialize_data(shared_domain.user, ViewerSerializer)
    end

    def destroy
      status = shared_domain.try(:destroy) ? :ok : :not_found
      head status
    end

    private

    def domain
      @domain ||= Domain.find(params[:domain_id])
    end

    def shared_domain
      @shared_domain ||= domain.shared_domains.find_by_user_id(params[:id])
    end
  end
end
