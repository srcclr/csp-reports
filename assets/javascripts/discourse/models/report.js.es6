let Report = Discourse.Model.extend({});

Report.reopenClass({
  createFromJson(json) {
    return this.create({
      createdAt: json.created_at,
      documentUri: json.result["document-uri"],
      referrer: json.result["referrer"],
      violatedDirective: json.result["violated-directive"],
      originalPolicy: json.result["original-policy"],
      blockedUri: json.result["blocked-uri"],
    })
  }
});

export default Report;
