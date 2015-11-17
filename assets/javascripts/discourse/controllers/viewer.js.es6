import { popupAjaxError } from "discourse/lib/ajax-error";

export default Ember.Controller.extend({
  actions: {
    destroy() {
      this.get("model").destroy(this.get("parentController.model.id")).then(() => {
        this.get("parentController.model.viewers").removeObject(this.get("model"))
        this.get("parentController.model.candidateViewers").pushObject(this.get("model"));
        this.set("parentController.selectedViewer", this.get("model"));
      }).catch(popupAjaxError);
    }
  }
})
