import Report from "./report";
import Viewer from "./viewer";

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
    }).then((res) => {
      this.get("viewers").pushObject(Viewer.createFromJson(res.viewer));
      this.get("candidateViewers").removeObject(this.candidateViewers.findProperty("id", res.viewer.id));
    });
  }
});

Domain.reopenClass({
  createFromJson(json) {
    return this.create({
      id: json.id,
      name: json.name,
      url: json.url,
      isOwn: json.own_domain,
      reports: _.map(json.reports, (report) => { return Report.createFromJson(report); }),
      viewers: _.map(json.viewers, (viewer) => { return Viewer.createFromJson(viewer); }),
      candidateViewers: _.map(json.candidate_viewers, (viewer) => { return Viewer.createFromJson(viewer); })
    });
  }
});

export default Domain;
