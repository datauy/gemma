import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { section: Number, question: Number, id: Number, position: Number }
  static targets = ["weight", "question"]
  
  connect() {
    if ( this.hasQuestionValue ) {
      console.log("CONNECT POLLS", this.questionValue);
      this.update_conditions()
    }
  }
  questionUp(e) {
    e.preventDefault()
    console.log('QUESTION UP target', window.section[this.sectionValue]['questions'])
    //Get question holder
    let qindex = window.section[this.sectionValue]['questions'].indexOf(this.questionValue);
    if ( qindex > 0 ) {
      //Get previous item
      let previous_q = document.getElementById('question-'+window.section[this.sectionValue]['questions'][(qindex - 1)])
      let previous_q_id = window.section[this.sectionValue]['questions'][(qindex - 1)]
      //Change indexes
      window.section[this.sectionValue]['questions'].splice((qindex + 2), 0, this.questionValue)
      window.section[this.sectionValue]['questions'].splice(qindex, 1)
      //move items
      previous_q.before(this.questionTarget)
      //Change items weight
      this.weightTarget.value = this.weightTarget.value - 1
      previous_q.querySelector("[data-polls-target='weight']").value = previous_q.querySelector("[data-polls-target='weight']").value + 1
    }
  }
  questionDown(e) {
    e.preventDefault()
    console.log('QUESTION DOWN!', window.section[this.sectionValue]['questions'])
    //Get question holder
    let qindex = window.section[this.sectionValue]['questions'].indexOf(this.questionValue);
    if ( qindex < (window.section[this.sectionValue]['questions'].length -1) ) {
      //Get previous item
      let next_q = document.getElementById('question-'+window.section[this.sectionValue]['questions'][(qindex + 1)])
      let next_q_id = window.section[this.sectionValue]['questions'][(qindex + 1)]
      //Change indexes
      window.section[this.sectionValue]['questions'].splice((qindex), 0, next_q_id)
      console.log('QUESTION DOWN! after', window.section[this.sectionValue]['questions'])
      window.section[this.sectionValue]['questions'].splice((qindex + 2), 1)
      //move items
      next_q.after(this.questionTarget)
      //Change items weight
      this.weightTarget.value = this.weightTarget.value + 1
      next_q.querySelector("[data-polls-target='weight']").value = next_q.querySelector("[data-polls-target='weight']").value - 1
    }
  }
  questionDelete(e) {
    e.preventDefault()
    console.log('QUESTION DELETE!', this.questionValue)
    if (window.new_questions.includes(this.questionValue)) {
      // delete form_node
      window.new_questions.filter(item => item !== this.questionValue);
      this.questionTarget.remove()
      let sindex = window.new_questions.indexOf(this.questionValue)
      if (sindex != -1 ) {
        window.new_questions.splice(sindex, 1)
      }
    }
    else {
      //Mark for destroy
      this.questionTarget.querySelector("[name$='[_destroy]']").value = 1
      //Hide in view
      this.questionTarget.hidden = true
      //Remove from select?
    }
    //Remove from lists
    let sindex = window.section[this.sectionValue]['questions'].indexOf(this.questionValue)
    if (sindex != -1 ) {
      window.section[this.sectionValue]['questions'].splice(sindex, 1)
    }
    //window.questions.push(e.target.value)
    let qindex = window.questions.indexOf(this.questionValue)
    if (qindex != -1 ) {
      window.questions.splice(qindex, 1)
    }
    window.deleted_questions.push(this.questionValue)
    //Todo make targwts
    //Check for questions or empty section container
    let sectionContainer = document.getElementById('poll-section-'+this.sectionValue)
    let display_section = false
    sectionContainer.querySelectorAll('.question').forEach(q =>{
      if (!q.hidden ) {
        display_section = true
        return
      }
    })
    if (!display_section) {
      let semaphore = sectionContainer.querySelector('.section-semaphore')
      let destroy = semaphore.querySelectorAll('[name$="[_destroy]"]')
      console.log("SEMAPHORE FOR DESTROY", destroy);
      if ( destroy.length > 0 ) {
        //Hide and mark for destroy
        semaphore.style.display = 'none'
        destroy.forEach(d => {
          d.value = 1
        })
      }
      else {
        semaphore.remove()
      }
    }
    this.update_conditions()
  }
  questionGetSemaphore(e) {
    e.preventDefault()
    console.log('GET QUESTION VALUES!!', this.questionValue)
    let dinamic = document.querySelector('#dinamic_question_'+this.questionValue)
    if ( dinamic.classList.contains('active') ) {
      dinamic.classList.remove('active')
    }
    else {
      document.querySelectorAll('.dinamic-question').forEach((dq) => {
        dq.classList.remove('active')
      })
      dinamic.classList.add('active')
      fetch('/question/get_semaphore/'+this.questionValue, {
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
  }
  //
  questionGetOptions(e) {
    e.preventDefault()
    console.log('GET QUESTION VALUES!!', this.questionValue)
    let dinamic = document.querySelector('#dinamic_question_'+this.questionValue)
    if ( dinamic.classList.contains('active') ) {
      dinamic.classList.remove('active')
    }
    else {
      dinamic.classList.add('active')
      fetch('/question/get_options/'+this.questionValue, {
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
  }
  //
  add_section(e) {
    //todo set section enabled
    document.getElementById('poll-section-'+e.target.value).style.display = 'flex'
  }
  //
  selectQuestion(e) {
    console.log('SELECT QUESTION pos', this.idValue);
    
    fetch('/add_section_question/'+e.target.value+'?poll_id='+this.idValue+'&qqtty='+window.questions.length+'&section_id='+this.sectionValue+'&isec='+this.positionValue+'&sqtty='+window.section[this.sectionValue]['questions'].length, {
      method: "GET",
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(r => r.text())
    .then(html => {
      window.questions.push(e.target.value)
      window.new_questions.push(e.target.value)
      window.section[this.sectionValue]['questions'].push(e.target.value)
      //Remove from deleted
      let qindex = window.deleted_questions.indexOf(this.questionValue)
      if (qindex != -1 ) {
        window.deleted_questions.splice(qindex, 1)
      }
      //remove from select
      for (let i = 0; i < e.target.options.length; i++) {
        if ( e.target.options[i].value == e.target.value ) {
          e.target.options[i].remove()
        }
      }
      //hide select
      e.target.classList.toggle('active')
      Turbo.renderStreamMessage(html)
      this.update_conditions()
    })
  }
  //
  getSectionQuestions(e) {
    e.preventDefault()
    let sectionSelect = document.getElementById('new_question_'+this.sectionValue)
    sectionSelect.classList.toggle('active')
    /*let url = '/get_section_questions/'+this.sectionValue
    let params = []
    if (window.new_questions.length > 0 ) {
      params.push('not_in='+window.new_questions)
    }
    if ( this.idValue ) {
      params.push("poll_id="+this.idValue)
    }
    if (params.length > 0 ) {
      url += '?'+params.join('&')
    }
    fetch(url, {
      method: "GET",
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(r => r.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
      this.delay(200).
      then(() => {
        console.log("Dinamic options", this.sectionValue)
        /*let section_options = document.querySelector('select[data-polls-section-value="'+this.sectionValue+'"]')
        for (let i = 0; i < section_options.length; i++) {
          if ( window.questions.includes(section_options[i]) ) {
            section_options.remove(i)
          }
        }*/
        /*new SlimSelect({
          select: "#new_poll_question",   // this.element is the <select> tag
          showSearch: true,       // show search field
          settings: {
            searchPlaceholder: 'Buscar',
            allowDeselect: true   // allow deselecting (x) option
          }
        })
      })
    })*/
  }
  update_conditions() {
    //TODO: Change condition_question to this: https://stimulus.hotwired.dev/reference/targets
    document.querySelectorAll('.question-condition').forEach((condition) => {
      console.log("CONDITIONS UPDATE SELECT", condition);
      window.questions.forEach(q => {
        if ( condition.querySelector('option[value="'+q+'"]') == null && !condition.classList.contains('question-condition-'+q) ) {
          condition.appendChild(new Option(q,q));
        }
        //Remove self
        if ( condition.classList.contains('question-condition-'+q) && condition.querySelector('option[value="'+q+'"]') != null ) {
          condition.querySelector('option[value="'+q+'"]').remove()
        }
      });
      //Delete questions
      window.deleted_questions.forEach(q => {
        let deleted_option = condition.querySelector('option[value="'+q+'"]')
        if (deleted_option != null ) {
          deleted_option.remove()
        }
      })
    })
  }
  delay(milliseconds){
    return new Promise(resolve => {
        setTimeout(resolve, milliseconds)
    })
  }
}
