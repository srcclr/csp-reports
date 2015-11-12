module CspReports
  class ViewersController < ApplicationController
    skip_before_action :redirect_to_login_if_required, :check_xhr

    before_action :ensure_logged_in

    respond_to :html, :json

    def create
    end

    def index
    end

    def destroy
    end
  end
end
