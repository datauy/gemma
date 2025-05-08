import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  
  connect() {
    this.filterOptions = this.filter_options_delay.bind(this)
    let add_new = document.querySelector('.has-many-add')
    add_new.addEventListener("click", this.filterOptions)
    this.filter_options(null, true)
  }
  //
  /*trigger_controllers() {
    console.log("TRIGGER CONTROLLERS");
    
    const trigger = new CustomEvent("trigger-red");
    window.dispatchEvent(trigger);
  }*/
  filter_options_delay() {
    this.delay(300).then(
      this.filter_options(null, true)
    )
  }
  filter_options(e, click=false) {
    let qtype = document.getElementById('question_qtype').value
    if (qtype != 'Opciones' ) {
      if ( document.querySelector('.has-many-remove') != null ) {
        //Remove all options
        document.querySelectorAll('.has-many-remove').forEach(element => {
          element.click()
        });
      }
      document.querySelector('.has-many-add').style.display = 'none'
    }
    if (qtype != 'Texto' && !click) {
      //Add option
      document.querySelector('.has-many-add').click()
    }
    console.log("FILTER OPTIOINS", qtype);
    this.delay(200).then(() => {
      switch (qtype) {
        case 'Numérica':
          //temp0.parentNode.firstChild.innerHTML = 
          this.toggle_nodes('.options-title', false)
          this.toggle_nodes('.options-value', false)
          this.toggle_nodes('.options-prefix', true)
          this.toggle_nodes('.options-sufix', true)
          break;
        case 'Texto':
          break;
        case 'Adjunto':
          this.toggle_nodes('.options-title', true)
          this.toggle_nodes('.options-value', true)
          this.toggle_nodes('.options-prefix', false)
          this.toggle_nodes('.options-sufix', false)
          break;
        case 'Opciones':
          //Opciones
          this.toggle_nodes('.options-title', true)
          this.toggle_nodes('.options-value', true)
          this.toggle_nodes('.options-prefix', false)
          this.toggle_nodes('.options-sufix', false)
          document.querySelector('.has-many-add').style.display = 'block'
          break;
      }
    })
  }
  toggle_nodes(nclass, display) {
    console.log(nclass, display);
    
    document.querySelectorAll(nclass).forEach(element => {
      element.parentNode.style.display = display ? 'flex' : 'none'
    });
  }
  delay(milliseconds){
    return new Promise(resolve => {
        setTimeout(resolve, milliseconds)
    })
  }
}
