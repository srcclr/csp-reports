export default Ember.Component.extend({
  currentPage: null,
  totalPages: null,
  maxPageButtons: 7,

  pageItems: Em.computed("currentPage", "totalPages", function() {
    let pages = [],
        currentPage = this.get("currentPage"),
        maxPageButtons = this.get("maxPageButtons"),
        totalPages = this.get("totalPages"),
        pagesMiddle = (maxPageButtons - 1) / 2,
        startPosition;

    for (let i = 1; i <= totalPages; i++) {
      pages.push({ page: i, current: currentPage == i })
    }

    if (currentPage <= pagesMiddle) {
      startPosition = 0;
    } else if (currentPage >= totalPages - pagesMiddle) {
      startPosition = totalPages - maxPageButtons;
    } else {
      startPosition = currentPage - pagesMiddle - 1;
    }

    if (startPosition < 0) { startPosition = 0 }

    return pages.slice(startPosition, startPosition + maxPageButtons);
  }),

  hasPages: Em.computed.gt("totalPages", 1),
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
