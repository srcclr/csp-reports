import CspReport from "../models/csp-report";

function fetchModel() {
  return () => { return Discourse.ajax(Discourse.getURL("/csp-reports/domains")); };
}

function wrapModel(json) {
  return CspReport.createFromJson(json);
}

export default Discourse.Route.extend({
  beforeModel() { return this.redirectIfLoginRequired(); },

  model() {
    return PreloadStore.getAndRemove('domains', fetchModel).then(wrapModel);
  }
})
