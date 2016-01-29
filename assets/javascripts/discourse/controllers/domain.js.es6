import Domain from "../models/domain";
import { popupAjaxError } from "discourse/lib/ajax-error";

export default Ember.Controller.extend({
  actions: {
    destroy() {
      this.get("model").destroy().then(() => {
        this.get("parentController.model.domains").removeObject(this.get("model"))
      }).catch(popupAjaxError);
    },

    setNotificationType(type) {
      this.get("model").setNotificationType(type).then(() => {
        this.get("model").set("email_notification.notification_type", type);
      }).catch(popupAjaxError);
    }
  }
})
