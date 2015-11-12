let Viewer = Discourse.Model.extend({});

Viewer.reopenClass({
  createFromJson(json) {
    return this.create({
      id: json.id,
      name: json.name
    })
  }
});

export default Viewer;
