import Domain from "../models/domain";

function fetchModel(params) {
  return () => { return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + params.id)); };
}

function wrapModel(json) {
  return Domain.createFromJson(json);
}

export default Discourse.Route.extend({
  beforeModel() { return this.redirectIfLoginRequired(); },

  model(params) {
    return PreloadStore.getAndRemove('domain', fetchModel(params)).then(wrapModel);
  },

  setupController(controller, model) {
    controller.set("model", model);
    this.controllerFor("application").set("showFooter", true);
  }
})
