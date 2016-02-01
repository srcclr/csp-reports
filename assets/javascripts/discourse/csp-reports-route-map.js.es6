export default function() {
  this.resource("csp-reports");
  this.route("domain", { path: "csp-reports/domains/:id" }, function() {
    this.route("reports-table", { path: "/" });
    this.route("reports-graph", { path: "/graph" });
    this.route("viewers", { path: "/viewers" });
  });
}
