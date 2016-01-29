let Viewer = Discourse.Model.extend({
  destroy(domainId) {
    return Discourse.ajax("/csp-reports/domains/" + domainId + "/viewers/" + this.get("id"), { type: "DELETE" });
  }
});

Viewer.reopenClass({
  createFromJson(json) {
    return this.create({
      id: json.id,
      username: json.username
    })
  },

  createList(json) {
    return _.map(json, (viewer) => { return this.createFromJson(viewer); })
  }
});

export default Viewer;
