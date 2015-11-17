import Report from "./report";
import Viewer from "./viewer";

let Domain = Discourse.Model.extend({
  destroy() {
    return Discourse.ajax("/csp-reports/domains/" + this.get("id"), { type: "DELETE" });
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
      reports: _.map(json.reports, (report) => { return Report.createFromJson(report); }),
      viewers: _.map(json.viewers, (viewer) => { return Viewer.createFromJson(viewer); }),
      candidateViewers: _.map(json.candidate_viewers, (viewer) => { return Viewer.createFromJson(viewer); })
    });
  }
});

export default Domain;
