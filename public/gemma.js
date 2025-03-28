question_type_change()
function question_type_change(){
  let qtype = document.getElementById('question_qtype')
  console.log("LAMADA PARA PEPE", qtype)
  document.querySelectorAll('.options').forEach(option => {
    if (option.id == 'input_'+qtype.value ) {
      option.style.display = "flex"
    }
    else {
      option.style.display = "none"
    }
  });
}