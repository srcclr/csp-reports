import Domain from "../models/domain";

export default Discourse.Route.extend({
  beforeModel() { return this.redirectIfLoginRequired(); },

  model(params) {
    return PreloadStore.getAndRemove('domain', () => {
      return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + params.id));
    }).then((data) => {
      return Domain.createFromJson(data);
    });
  },

  setupController(controller, model) {
    controller.set("model", model);
    this.controllerFor("application").set("showFooter", true);
  }
})
