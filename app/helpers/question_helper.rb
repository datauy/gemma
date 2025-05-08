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
end
