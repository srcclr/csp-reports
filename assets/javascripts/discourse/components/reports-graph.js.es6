import ChartGraph from "../../lib/chart-graph"

export default Ember.Component.extend({
  tagName: "canvas",
  classNames:  ["category-canvas"],
  attributeBindings: ["width", "height"],
  width: 960,
  height: 480,

  draw: function() {
    new ChartGraph(this.get("element"), { reports: this.model }).draw();
  }.on("didInsertElement"),
})
