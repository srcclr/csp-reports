require_dependency "email/message_builder"

class CspViolationsReportMailer < ActionMailer::Base
  include Email::BuildEmailHelper

  def report(notification)
    build_email(
      notification.user.email,
      template: "csp_violations_report",
      notification_type: notification.notification_type.titleize,
      username: notification.user.username,
      domain_name: notification.domain.name,
      domain_url: notification.domain.url,
      report_url: "#{Discourse.base_url}/csp-reports/domains/#{notification.domain.id}"
    )
  end
end
