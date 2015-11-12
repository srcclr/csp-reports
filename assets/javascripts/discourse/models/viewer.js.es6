let Viewer = Discourse.Model.extend({});

Viewer.reopenClass({
  createFromJson(json) {
    return this.create({
      id: json.id,
      username: json.username
    })
  }
});

export default Viewer;
