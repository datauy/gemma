import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets=["infopanel", "infotrigger"]

  connect() {
  }

  toggleInfo() {
    console.log("TOGGLE INFO", this.infotriggerTarget);
    if ( this.infotriggerTarget.ariaExpanded == "true" ) {
      this.infotriggerTarget.ariaExpanded = false
      this.infopanelTarget.style.display = 'none'
    }
    else {
      this.infotriggerTarget.ariaExpanded = true
      this.infopanelTarget.style.display = 'flex'
    }
  }
}
