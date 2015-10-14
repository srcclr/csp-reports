import Report from "./report";

let Domain = Discourse.Model.extend({
  destroy() {
    return Discourse.ajax("/csp-reports/domains/" + this.get("id"), { type: "DELETE" });
  }
});

Domain.reopenClass({
  createFromJson(json) {
    return this.create({
      id: json.id,
      name: json.name,
      url: json.url,
      reports: _.map(json.reports, (report) => { return Report.createFromJson(report); })
    });
  }
});

export default Domain;
