import Domain from "./domain";

let CspReport = Discourse.Model.extend({
  addDomain(data) {
    return Discourse.ajax("/csp-reports/domains", {
      type: "POST",
      data: { domain: data }
    }).then((res) => { this.domains.pushObject(Domain.create(res.domain)); });
  }
});

CspReport.reopenClass({
  createFromJson(json) {
    return this.create({
      reportUri: json.report_uri,
      domains: _.map(json.domains, (domain) => { return Domain.create(domain); }),
      friend_domains: _.map(json.friend_domains, (domain) => { return Domain.create(domain); })
    });
  }
});

export default CspReport;
