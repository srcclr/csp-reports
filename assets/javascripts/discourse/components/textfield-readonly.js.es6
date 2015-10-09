export default Ember.TextField.extend({
  readonly: true,

  focusIn() {
    this.element.select()
  }
});
