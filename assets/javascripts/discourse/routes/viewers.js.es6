import Viewer from "../models/viewer";

export default Discourse.Route.extend({
  beforeModel() { return this.redirectIfLoginRequired(); },

  model(params) {
    return PreloadStore.getAndRemove('viewers', () => {
      return Discourse.ajax(Discourse.getURL("/csp-reports/domains" + params.id + "/viewers"));
    }).then((data) => {
      return Viewer.createFromJson(data);
    });
  },

  setupController(controller, model) {
    controller.set("model", model);
    this.controllerFor("application").set("showFooter", true);
  }
})
