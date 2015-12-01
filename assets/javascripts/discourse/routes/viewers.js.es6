import Viewer from "../models/viewer";
import RedirectIfNotLoggedIn from "../mixins/redirect-if-not-logged-in";

export default Discourse.Route.extend(RedirectIfNotLoggedIn, {
  redirect() { return this.redirectIfNotLoggedIn("/projects/csp-reports"); },

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
