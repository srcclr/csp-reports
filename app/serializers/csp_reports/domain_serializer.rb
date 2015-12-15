module CspReports
  class DomainSerializer < ActiveModel::Serializer
    attributes :id, :name, :url, :email_notification
    delegate :current_user, to: :scope

    def email_notification
      { notification_type: current_user_email_notification.try(:notification_type) || "never" }
    end

    private

    def current_user_email_notification
      @current_user_email_notification ||= object.email_notifications.find_by(user: current_user)
    end
  end
end
