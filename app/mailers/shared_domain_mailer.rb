require_dependency "email/message_builder"

class SharedDomainMailer < ActionMailer::Base
  include Email::BuildEmailHelper

  def send_notification(args)
    user = User.find_by(id: args[:user_id])
    domain = CspReports::Domain.find_by(id: args[:domain_id])
    build_email(
      user.email,
      template: "shared_domain_mailer",
      username: user.username,
      domain_username: domain.username,
      domain_link: "#{Discourse.base_url}/csp-reports/domains/#{domain.id}",
      domain_url: domain.url
    )
  end
end
