import GraphReport from "../models/graph-report";

export default Discourse.Route.extend({
  model(params) {
    let domainId = this.modelFor("domain").get("id");

    return PreloadStore.getAndRemove('reports', () => {
      return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + domainId + "/graph"));
    }).then((data) => {
      return GraphReport.createList(data);
    });
  },

  setupController(controller, model) {
    controller.setProperties({ model: model, filter: "day" });
    this.controllerFor("application").set("showFooter", true);
  }
})
