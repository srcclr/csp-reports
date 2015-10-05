function fetchModel() {
  return () => { return Discourse.ajax(Discourse.getURL("/csp-violation-tool/reports")); };
}

function wrapModel(json) {
  return {
    reportUri: json.report_uri
  }
}

export default Discourse.Route.extend({
  beforeModel() { return this.redirectIfLoginRequired(); },

  model() {
    return PreloadStore.getAndRemove('reports', fetchModel).then(wrapModel);
  }
})
