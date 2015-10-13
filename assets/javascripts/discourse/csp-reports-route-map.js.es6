export default function() {
  this.resource("csp-reports");
  this.route("domain", { path: "csp-reports/domains/:id" });
}
