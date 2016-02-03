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

  isFirstPage: Em.computed.equal("currentPage", 1),
  isLastPage: Em.computed("currentPage", function() {
    return this.get("currentPage") == this.get("totalPages");
  }),

  actions: {
    pageClicked(pageNumber) {
      this.set("currentPage", pageNumber);
      this.sendAction("action", pageNumber);
    },

    nextPage() {
      this.send("pageClicked", this.get("currentPage") + 1);
    },

    prevPage() {
      this.send("pageClicked", this.get("currentPage") - 1);
    }
  }
})
