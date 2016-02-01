import Viewer from "../models/viewer";
import { popupAjaxError } from "discourse/lib/ajax-error";

export default Ember.Controller.extend({
  needs: ["domain"],
  selectedViewer: null,

  isOwn: Em.computed.alias("controllers.domain.content.isOwn"),

  actions: {
    addViewer() {
      let domain = this.get("controllers.domain.model");

      domain.addViewer(this.get("selectedViewer")).then((res) => {
        this.get("model.viewers").pushObject(Viewer.createFromJson(res.viewer));
        this.get("model.candidateViewers").removeObject(this.get("model.candidateViewers").findProperty("id", res.viewer.id));
        this.set("selectedViewer", this.get("model.candidateViewers.0"));
      }).catch(popupAjaxError);
    }
  }
})
