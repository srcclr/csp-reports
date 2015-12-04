module Jobs
  module CspReports
    class Daily < Jobs::CspReports::Base
      every 1.day

      def initialize
        @notification_type = "daily"
      end
    end
  end
end
