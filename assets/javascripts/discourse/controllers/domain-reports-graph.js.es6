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
    return "?from=" + this.get("fromDate") + "&to=" + this.get("toDate");
  }),

  fromDate: Em.computed("filter", function() {
    return moment.utc().subtract(1, this.get("filter")).format(dateFormat);
  }),

  toDate: Em.computed("filter", function() {
    return moment.utc().endOf("day").format(dateFormat);
  }),

  dateInterval: Em.computed("fromDate", "toDate", function() {
    let filter = this.get("filter");

    if (filter == "day") {
      return 24;
    } else if (filter == "year") {
      return 12;
    } else {
      return Math.ceil((moment(this.get("toDate")) - moment(this.get("fromDate"))) / (24 * 3600 * 1000));
    }
  }),

  emptyDateInterval: Em.computed("model", function() {
    let empty = {},
        filter = this.get("filter"),
        fromDate = this.get("fromDate");

    for (let i = 0; i < this.get("dateInterval"); i++) {
      let date;

      if (filter == "day") {
        date = moment(fromDate).add(i, "hours").format("YYYY-MM-DDTHH:00");
      } else if (filter == "year") {
        date = moment(fromDate).add(i, "months").format("YYYY-MM");
      } else {
        date = moment(fromDate).add(i, "days").format("YYYY-MM-DD");
      }

      empty[date] = 0;
    }

    return empty;
  }),

  resultsDateInterval: Em.computed("model", function() {
    let filter = this.get("filter"),
        results;

    results = _.countBy(this.get("model"), (report) => {
      if (filter == "day") {
        return report.createdAt.slice(0, 13) + ":00";
      } else if (filter == "year") {
        return report.createdAt.slice(0, 7);
      } else {
        return report.createdAt.split("T")[0];
      }
    });

    return results;
  }),

  groupedReports: Em.computed("model", function() {
    return _.pairs(_.extend(this.get("emptyDateInterval"), this.get("resultsDateInterval")));
  }),

  actions: {
    filter(range) {
      this.set("filter", range);
    }
  }
})
