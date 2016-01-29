import Report from "../models/report";

export default Discourse.Route.extend({
  model(params) {
    let domainId = this.modelFor("domain").get("id");

    return PreloadStore.getAndRemove('reports', () => {
      return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + domainId + "/reports"));
    }).then((data) => {
      return Report.createList(data);
    });
  },

  setupController(controller, model) {
    controller.set("model", model);
    this.controllerFor("application").set("showFooter", true);
  }
})
