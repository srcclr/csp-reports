import TableReport from "../models/table-report";

export default Discourse.Route.extend({
  model(params) {
    let domainId = this.modelFor("domain").get("id");

    return PreloadStore.getAndRemove('reports', () => {
      return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + domainId + "/reports"));
    }).then((data) => {
      return TableReport.createList(data);
    });
  },

  setupController(controller, model) {
    controller.setProperties({ model: model, filter: "day" });
    this.controllerFor("application").set("showFooter", true);
  }
})
