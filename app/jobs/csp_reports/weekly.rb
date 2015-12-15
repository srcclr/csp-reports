module Jobs
  module CspReports
    class Weekly < Jobs::CspReports::Base
      every 1.week

      def initialize
        @notification_type = "weekly"
      end
    end
  end
end
