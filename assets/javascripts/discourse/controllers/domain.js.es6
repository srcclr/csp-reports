import { popupAjaxError } from "discourse/lib/ajax-error";

export default Ember.Controller.extend({
  actions: {
    destroy() {
      this.get("model").destroy().then(() => {
        this.get("parentController.model.domains").removeObject(this.get("model"))
      }).catch(popupAjaxError);
    }
  }
})
