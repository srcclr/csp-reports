export default Ember.Component.extend({
  perPage: null,

  items: Em.computed(function() {
    let availableCounts = [25, 50, 100],
        perPage = this.get("perPage");

    return _.map(availableCounts, (count) => {
      return {
        count: count,
        current: count == perPage
      }
    })
  }),

  actions: {
    changePerPageItemsCount(count) {
      this.sendAction("action", count);
    }
  }
})
