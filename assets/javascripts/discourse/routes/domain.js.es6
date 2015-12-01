import Domain from "../models/domain";
import RedirectIfNotLoggedIn from "../mixins/redirect-if-not-logged-in";

export default Discourse.Route.extend(RedirectIfNotLoggedIn, {
  redirect() { return this.redirectIfNotLoggedIn("/projects/csp-reports"); },

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
