import CspReport from "../models/csp-report";

export default Discourse.Route.extend({
  beforeModel() { return this.redirectIfLoginRequired(); },

  model() {
    return PreloadStore.getAndRemove('domains', () => {
      return Discourse.ajax(Discourse.getURL("/csp-reports/domains"));
    }).then((data) => {
      return CspReport.createFromJson(data);
    });
  },

  setupController(controller, model) {
    controller.set("model", model);
    this.controllerFor("application").set("showFooter", true);
  }
})
