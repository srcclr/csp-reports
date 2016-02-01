import { popupAjaxError } from "discourse/lib/ajax-error";

export default Ember.Controller.extend({
  needs: ["domain"],

  actions: {
    destroy() {
      let domainId = this.get("controllers.domain.model.id");

      this.get("model").destroy(domainId).then(() => {
        this.get("parentController.model.viewers").removeObject(this.get("model"))
        this.get("parentController.model.candidateViewers").pushObject(this.get("model"));
        this.set("parentController.selectedViewer", this.get("model"));
      }).catch(popupAjaxError);
    }
  }
})
