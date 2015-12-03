module CspReports
  class DomainSerializer < ActiveModel::Serializer
    attributes :id, :name, :url, :email_notification

    def email_notification
      {
        never: current_user_email_notification.blank?,
        daily: current_user_email_notification.try(:daily?),
        weekly: current_user_email_notification.try(:weekly?),
        monthly: current_user_email_notification.try(:monthly?)
      }
    end

    private

    def current_user_email_notification
      @current_user_email_notification ||= object.email_notifications.find_by(user: options[:current_user])
    end
  end
end
