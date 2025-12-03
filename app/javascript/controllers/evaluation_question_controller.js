import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="evaluation-question"
export default class extends Controller {
  static values = { cquestion: Number }
  static targets = ["qinput"]
  connect() {
  }
  //
  changeInput() {
    console.log(this.hasQinputTarget)
    console.log(this.qinputTarget);
    if ( window.cquestions.hasOwnProperty(this.cquestionValue) ) {
      let formula = this.qinputTarget.value + window.cquestions[this.cquestionValue].formula
      if ( eval(formula) ) {
        document.getElementById(window.cquestions[this.cquestionValue].target).style.display = "flex"
      }
      else {
        document.getElementById(window.cquestions[this.cquestionValue].target).style.display = "none"
      }
    } 
  }
}
