export default Ember.Component.extend({
  currentPage: null,
  totalPages: null,

  pageItems: Em.computed("currentPage", "totalPages", function() {
    let pages = [];

    for (let i = 1; i <= this.get("totalPages"); i++) {
      pages.push({ page: i, current: this.get("currentPage") == i })
    }

    return pages;
  }),

  actions: {
    pageClicked: function(pageNumber) {
      this.set("currentPage", pageNumber);
      this.sendAction("action", pageNumber);
    }
  }
})
