require_dependency "email/message_builder"

class CspViolationsReportMailer < ActionMailer::Base
  include Email::BuildEmailHelper

  def report(notification)
    email_opts = {
      template: "csp_violations_report",
      html_override: html(notification),
      notification_type: notification.notification_type.titleize
    }

    build_email(notification.user.email, email_opts)
  end

  private

  def html(notification)
    ActionView::Base.new("plugins/csp-reports/app/views").render(
      template: 'email/csp_reports',
      format: :html,
      locals: {
        reports: notification.domain.reports
          .for_type(notification.notification_type)
          .order(id: :desc)
          .limit(10),
        notification_type: notification.notification_type.titleize,
        username: notification.user.username,
        domain_name: notification.domain.name,
        domain_url: notification.domain.url,
        report_url: "#{Discourse.base_url}/csp-reports/domains/#{notification.domain.id}"
      }
    )
  end
end
