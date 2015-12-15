require_dependency "email/sender"

module Jobs
  class SharedDomain < Jobs::Base
    def execute(args)
      fail Discourse::InvalidParameters.new(:user_id) unless args[:user_id].present?
      message = SharedDomainMailer.send_notification(args)
      Email::Sender.new(message, :shared_domain).send
    end
  end
end
