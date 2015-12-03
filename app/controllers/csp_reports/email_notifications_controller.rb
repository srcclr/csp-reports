module CspReports
  class EmailNotificationsController < ::ApplicationController
    skip_before_action :check_xhr, :redirect_to_login_if_required, :verify_authenticity_token

    def update
      current_user.email_notifications.find_or_create!(csp_reports_domain_id: params["csp_reports_domain_id"])
    end
  end
end
