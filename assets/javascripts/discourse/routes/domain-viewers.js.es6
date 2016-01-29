import Viewer from "../models/viewer";

export default Discourse.Route.extend({
  model(params) {
    let domainId = this.modelFor("domain").get("id");

    return PreloadStore.getAndRemove('viewers', () => {
      return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + domainId + "/viewers"));
    }).then((data) => {
      return {
        viewers: Viewer.createList(data.viewers),
        candidateViewers: Viewer.createList(data.candidate_viewers)
      }
    });
  },

  setupController(controller, model) {
    controller.set("model", model);
    this.controllerFor("application").set("showFooter", true);
  }
})
