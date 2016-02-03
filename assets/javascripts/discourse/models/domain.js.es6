let Domain = Discourse.Model.extend({
  isNever: Em.computed.equal("email_notification.notification_type", "never"),
  isDaily: Em.computed.equal("email_notification.notification_type", "daily"),
  isWeekly: Em.computed.equal("email_notification.notification_type", "weekly"),
  isMonthly: Em.computed.equal("email_notification.notification_type", "monthly"),

  destroy() {
    return Discourse.ajax("/csp-reports/domains/" + this.get("id"), { type: "DELETE" });
  },

  setNotificationType(type) {
    return Discourse.ajax("/csp-reports/domains/" + this.get("id") + "/email_notifications" , { type: "PUT", data: { notification_type: type } });
  },

  addViewer(viewer) {
    return Discourse.ajax("/csp-reports/domains/" + this.id + "/viewers", {
      type: "POST",
      data: { user_id: viewer.id }
    });
  }
});

Domain.reopenClass({
  createFromJson(json) {
    return this.create({
      id: json.id,
      name: json.name,
      owner: json.username,
      url: json.url,
      isOwn: json.own_domain
    });
  }
});

export default Domain;
