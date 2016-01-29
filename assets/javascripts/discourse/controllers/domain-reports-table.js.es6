import Report from "../models/report"
import { popupAjaxError } from "discourse/lib/ajax-error";

const dateFormat = "YYYY-MM-DDTHH:mm:ss";

export default Ember.Controller.extend({
  needs: ["domain"],

  filter: "all",
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

  filterQuery: Em.computed("filter", function() {
    let filter = this.get("filter");

    if (filter == "all") { return ""; }

    let from = moment.utc().startOf(filter).format(dateFormat),
        to = moment.utc().endOf(filter).format(dateFormat);

    return "?from=" + from + "&to=" + to;
  }),

  actions: {
    filter(range) {
      this.set("filter", range);
    }
  }
})
