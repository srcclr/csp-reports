import Domain from "../models/domain";
import { popupAjaxError } from "discourse/lib/ajax-error";

const dateFormat = "YYYY-MM-DDTHH:mm:ss";

export default Ember.Controller.extend({
  filter: "all",
  loading: false,
  filterQuery: "",

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

  actions: {
    filter_all() {
      this.set("filter", "all");
    },

    filter_today() {
      this.set("filter", "day");
    },

    filter_week() {
      this.set("filter", "week");
    },

    filter_month() {
      this.set("filter", "month");
    },

    filter_quarter() {
      this.set("filter", "quarter");
    },

    filter_year() {
      this.set("filter", "year");
    },

    destroy() {
      this.get("model").destroy().then(() => {
        this.get("parentController.model.domains").removeObject(this.get("model"))
      }).catch(popupAjaxError);
    }
  }
})
