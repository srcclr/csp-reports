module CspReports
  class ViewersController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr

    before_action :ensure_logged_in

    respond_to :html, :json

    def create
    end

    def index
      respond_to do |format|
        format.html do
          store_preloaded("viewers", MultiJson.dump(viewers))
          render "default/empty"
        end

        format.json { render json: viewers }
      end
    end

    def destroy
    end

    private

    def viewers
      binding.pry
      serialize_data(
        domain.viewers,
        ViewerSerializer,
        root: false,
        host: request.base_url
      )
    end

    def domain
      @domain ||= Domain.find(params[:domain_id])
    end
  end
end
