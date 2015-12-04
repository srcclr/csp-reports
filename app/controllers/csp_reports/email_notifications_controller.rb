module CspReports
  class EmailNotificationsController < ::ApplicationController
    skip_before_action :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    def update
      notification = current_user.email_notifications.find_or_create_by(
        csp_reports_domain_id: params[:domain_id],
        notification_type: params[:notification_type]
      )

      render json: notification
    end
  end
end
