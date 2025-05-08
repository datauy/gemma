module PollHelper
  #Admin helpers
  def poll_admin_question(poll_id, question)
    "<div id='question-#{question.id}' class='question'>\
      <div class='id'>#{question.id}</div>\
      <div class='title'>#{question.title}</div>\
      <div class='condition'><span class='label'>Condición</span><div>FORM</div></div>\
      <div class='actions'>#{poll_actions(poll_id, question.id)}</div>\
      <div class='semaphore'>Semaphore</div>\
    </div>".html_safe
  end
  def poll_actions(poll_id, question_id)
    '<button data-action="click->polls#questionGetValues(1)">Ver valores</button><button>Borrar</button>'
  end

end
