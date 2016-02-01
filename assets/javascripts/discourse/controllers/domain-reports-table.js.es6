import Report from "../models/report"
import { popupAjaxError } from "discourse/lib/ajax-error";

const dateFormat = "YYYY-MM-DDTHH:mm:ss";

export default Ember.Controller.extend({
  needs: ["domain"],

  filter: "day",
  filterQuery: "",

  isAll: Em.computed.equal("filter", "all"),
  isToday: Em.computed.equal("filter", "day"),
  isWeek: Em.computed.equal("filter", "week"),
  isMonth: Em.computed.equal("filter", "month"),
  isQuarter: Em.computed.equal("filter", "quarter"),
  isYear: Em.computed.equal("filter", "year"),

  init() {
    this.get("filterQuery");
  },

  filterCollection: Em.observer("filterQuery", function() {
    let domain_id = this.get("controllers.domain.model.id"),
        query = this.get("filterQuery");

    this.set("loading", true);
    return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + domain_id + "/reports" + query)).then((data) => {
      this.set("model", Report.createList(data));
      this.set("loading", false);
    }).catch(popupAjaxError);
  }),

  fromDate: Em.computed("filter", function() {
    return moment.utc().subtract(1, this.get("filter")).format(dateFormat);
  }),

  toDate: Em.computed("filter", function() {
    return moment.utc().endOf("day").format(dateFormat);
  }),

  filterQuery: Em.computed("filter", function() {
    if (this.get("filter") == "all") { return "?all=1"; }

    return "?from=" + this.get("fromDate") + "&to=" + this.get("toDate");
  }),

  actions: {
    filter(range) {
      this.set("filter", range);
    }
  }
})
