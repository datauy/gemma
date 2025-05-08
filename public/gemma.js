question_type_change()
function question_type_change(){
  let qtype = document.getElementById('question_qtype')
  document.querySelectorAll('.options').forEach(option => {
    if (option.id == 'input_'+qtype.value ) {
      option.style.display = "flex"
    }
    else {
      option.style.display = "none"
    }
  });
}
document.addEventListener("turbolinks:load", function() {
  alert("TURBOSSS????");
});

function addPollQuestion(e, section_id) {
  e.preventDefault();
  console.log("LALA", e );
  console.log("PEPE", section_id );
  
}