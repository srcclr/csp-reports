import CspReport from "../models/csp-report";
import RedirectIfNotLoggedIn from "../mixins/redirect-if-not-logged-in";

export default Discourse.Route.extend(RedirectIfNotLoggedIn, {
  redirect() { return this.redirectIfNotLoggedIn("/projects/csp-reports"); },

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
