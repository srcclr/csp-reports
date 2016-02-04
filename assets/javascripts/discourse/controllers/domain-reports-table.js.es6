import TableReport from "../models/table-report"
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

  pageSelected: 1,
  currentPage: Em.computed.alias("model.meta.page"),
  totalPages: Em.computed("model.meta.@each", function() {
    let total = this.get("model.meta.total"),
        per = this.get("model.meta.per");

    return Math.ceil(total / per);
  }),

  filterCollection: Em.observer("filterQuery", function() {
    let domain_id = this.get("controllers.domain.model.id"),
        query = this.get("filterQuery");

    this.set("loading", true);
    return Discourse.ajax(Discourse.getURL("/csp-reports/domains/" + domain_id + "/reports" + query)).then((data) => {
      this.set("model", TableReport.createList(data));
      this.set("loading", false);
    }).catch(popupAjaxError);
  }),

  fromDate: Em.computed("filter", function() {
    return moment.utc().subtract(1, this.get("filter")).format(dateFormat);
  }),

  toDate: Em.computed("filter", function() {
    return moment.utc().endOf("day").format(dateFormat);
  }),

  filterQuery: Em.computed("filter", "pageSelected", function() {
    let query = "?page=" + this.get("pageSelected");

    if (this.get("filter") == "all") {
      query = query + "&all=1";
    } else {
      query = query + "&from=" + this.get("fromDate") + "&to=" + this.get("toDate");
    }

    return query;
  }),

  actions: {
    filter(range) {
      this.setProperties({ filter: range, pageSelected: 1 });
    },

    pageClicked(pageNumber) {
      this.set("pageSelected", pageNumber);
    }
  }
})
