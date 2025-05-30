module QuestionHelper
  def format_options(question)
    result = ''
    case question.qtype
    when "Opciones"
      result += "<div class='option-header option-#{question.qtype}'><div>Etiqueta</div><div>Valor</div></div>"
    when 'Numérica'
      result += "<div class='option-header option-#{question.qtype}'><div>Prefijo</div><div>Sufijo</div></div>"
    when 'Texto'
      result += "<div class='option-header option-#{question.qtype}'>No hay opciones disponibles para 'Texto'</div>"
    when'Adjunto'
      result += "<div class='option-header option-#{question.qtype}'><div>Etiqueta</div><div>Valor</div></div>"
    end
    question.options.each do |option|
      case question.qtype
      when "Opciones"
        result += "<div class='option option-#{question.qtype}'><div class='option-title'>#{option.title}</div><div class='option-value'>#{option.ovalue}</div></div>"
      when 'Numérica'
        result += "<div class='option option-#{question.qtype}'><div class='option-prefix'>#{option.prefix}</div><div class='option-sufix'>#{option.sufix}</div></div>"
      when'Adjunto'
        result += "<div class='option option-#{question.qtype}'><div class='option-title'>#{option.title}</div><div class='option-value'>#{option.ovalue}</div></div>"
      end
    end
    result.html_safe
  end

  def format_question(question)
    result = "<div class='question'>
    <div class='question-header'>
    <h4>#{question.title}</h4>
    <div class='description'>#{question.description}</div>
    </div>"
    case question.qtype
    when "Opciones"
      result += select_tag :"questions[#{question.id}]", options_for_select( question.options.pluck(:title,:id) )
    when 'Numérica'
      option = question.options.first
      result += "<div class='question-header'>#{option.prefix}<div>"
      if question.options.first.prefix.present?
        result += "<div class='prefix'>#{question.options.first.prefix}<div>"
      end
      result += number_field_tag :"questions[#{question.id}]"
      if question.options.first.sufix.present?
        result += "<div class='sufix'>#{question.options.first.prefix}<div>"
      end
    when 'Texto'
      result += text_field_tag :"questions[#{question.id}]"
    when'Adjunto'
      result += file_field_tag :"questions[#{question.id}]"
    end
    result += "</div>"
    result.html_safe
  end
end
