import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="company"
export default class extends Controller {
  static values = { area: Number, provision: Number }
  static targets = ["evaluation"]
  connect() {
    console.log("CONNECTED COMPANY")
  }

  selectFilter(e) {
    console.log("SELECT FILTER", e.target)
    console.log(this.hasAreaValue, this.hasProvisionValue)
    if ( e.target.id == 'provision' ) {
      this.provisionValue = e.target.value
      if (this.hasAreaValue && this.provisionValue ) {
        this.fetchPoll()
      }
    }
    else {
      this.areaValue = e.target.value
      if ( this.hasProvisionValue && this.areaValue ) {
        this.fetchPoll()
      }
    }
  }
  //
  fetchPoll() {
    fetch('/company/get-poll/'+this.areaValue+'/'+this.provisionValue, {
      method: "GET",
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(r => r.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
    })
  }
  //
  submitForm(event) {
    let isValid = this.validateForm(this.evaluationTarget);

    // If our form is invalid, prevent default on the event
    // so that the form is not submitted
    if (!isValid) {
      event.preventDefault();
    }
  }
  //
  validateForm() {
    let isValid = true;

    // Tell the browser to find any required fields
    let requiredFieldSelectors = 'textarea:required, input:required';
    let requiredFields = this.formTarget.querySelectorAll(requiredFieldSelectors);

    requiredFields.forEach((field) => {
      // For each required field, check to see if the value is empty
      // if so, we focus the field and set our value to false
      if (!field.disabled && !field.value.trim()) {
        field.focus();

        isValid = false;
      }
    });

    return isValid;
  }
}
