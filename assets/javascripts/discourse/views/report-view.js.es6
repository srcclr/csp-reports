export default Em.View.extend({
  tagName: "tbody",
  showExpanded: false,

  click(event) {
    this.toggleProperty("showExpanded");
  }
})
