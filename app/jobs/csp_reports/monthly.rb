module Jobs
  module CspReports
    class Monthly < Jobs::CspReports::Base
      every 1.month

      def initialize
        @notification_type = "monthly"
      end
    end
  end
end
