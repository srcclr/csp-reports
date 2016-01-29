import Report from "../models/report"
import { popupAjaxError } from "discourse/lib/ajax-error";

const dateFormat = "YYYY-MM-DDTHH:mm:ss";

export default Ember.Controller.extend({
  needs: ["domain"],

  filter: "day",
  filterQuery: "",

  isToday: Em.computed.equal("filter", "day"),
  isWeek: Em.computed.equal("filter", "week"),
  isMonth: Em.computed.equal("filter", "month"),
  isQuarter: Em.computed.equal("filter", "quarter"),
  isYear: Em.computed.equal("filter", "year"),

  init() {
    this.get("filterQuery");
  },

  filterCollection: Em.observer("filterQuery", function() {
    let domainId = this.get("controllers.domain.model.id"),
        query = this.get("filterQuery");

    this.set("loading", true);
    return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + domainId + "/reports" + query)).then((data) => {
      this.set("model", Report.createList(data));
      this.set("loading", false);
    }).catch(popupAjaxError);
  }),

  filterQuery: Em.computed("filter", function() {
    let filter = this.get("filter");

    let from = moment.utc().startOf(filter).format(dateFormat),
        to = moment.utc().endOf(filter).format(dateFormat);

    return "?from=" + from + "&to=" + to;
  }),

  groupedReports: Em.computed("model", function() {
    return _.pairs(_.countBy(this.get("model"), (report) => {
      return report.createdAt.split("T")[0];
    }));
  }),

  actions: {
    filter(range) {
      this.set("filter", range);
    }
  }
})
