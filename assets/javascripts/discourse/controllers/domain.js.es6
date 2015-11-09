import Domain from "../models/domain";
import { popupAjaxError } from "discourse/lib/ajax-error";

const dateFormat = "YYYY-MM-DDTHH:mm:ss";

export default Ember.Controller.extend({
  filter: "all",
  viewType: "table",
  loading: false,
  filterQuery: "",

  isAll: Em.computed.equal("filter", "all"),
  isToday: Em.computed.equal("filter", "day"),
  isWeek: Em.computed.equal("filter", "week"),
  isMonth: Em.computed.equal("filter", "month"),
  isQuarter: Em.computed.equal("filter", "quarter"),
  isYear: Em.computed.equal("filter", "year"),

  isTableView: Em.computed.equal("viewType", "table"),
  isGraphView: Em.computed.equal("viewType", "graph"),

  init() {
    this.get("filterQuery");
  },

  filterCollection: Em.observer("filterQuery", function() {
    let id = this.get("model.id"),
        query = this.get("filterQuery");

    this.set("loading", true);
    return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + id + query)).then((data) => {
      this.set("model", Domain.createFromJson(data));
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

  groupedReports: Em.computed("model.reports", function() {
    let reports = this.get("model.reports");

    return _.pairs(_.countBy(reports, (report) => {
      return report.createdAt.split("T")[0];
    }));
  }),

  actions: {
    filter(range) {
      this.set("filter", range);
    },

    changeType(type) {
      this.set("viewType", type);
    },

    destroy() {
      this.get("model").destroy().then(() => {
        this.get("parentController.model.domains").removeObject(this.get("model"))
      }).catch(popupAjaxError);
    }
  }
})
