module Jobs
  class CspViolationsReport < Jobs::Scheduled
    every 1.day

    def execute(args)
      send_to_users_with_notifications
    end

    private

    def send_to_users_with_notifications
      users.find_each do |user|
        puts "send email to #{user.email}"
      end
    end

    def users
      User.with_notifications("daily")
    end
  end
end
