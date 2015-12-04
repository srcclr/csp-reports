module Jobs
  module CspReports
    class Base < Jobs::Scheduled
      def execute(args)
        notifications.find_each do |notification|
          send_report(notification)
        end
      end

      private

      def notifications
        ::CspReports::EmailNotification.for_type(@notification_type)
      end

      def send_report(notification)
        report =  CspViolationsReportMailer.report(notification)
        Email::Sender.new(report, :csp_reports).send

        puts "send email to #{notification.user.email}"
      end
    end
  end
end
