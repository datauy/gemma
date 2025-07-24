class EvaluationsController < ApplicationController
  before_action :authenticate_company!, :company_is_confirmed
  skip_before_action :company_is_confirmed, only: [:create, :edit]

  #
  def company_is_confirmed
    if !current_company.is_confirmed
      redirect_to dashboard_path
    end
  end
  # INDEX??
  def index
    @evaluation = Evaluation.find_by(id: params[:id])
    if @evaluation.present? && @evaluation.company_id == current_company.id

    else
      redirect_to dashboard_path()
    end
  end
  #
  def create
    if params[:evaluation].present?
      params[:evaluation][:company_id] = current_company.id
      @poll = Poll.find(params[:evaluation][:poll_id])
      if params[:commit] == "Evaluar"
        if current_company.is_confirmed
          params[:evaluation][:is_submitted] = true
          params[:evaluation][:submitted_date] = Time.current
          @evaluation = Evaluation.create(evaluation_create_params)
          self.process_evaluation
        else
          @evaluation = Evaluation.create(evaluation_create_params)
        end
      else
        @evaluation = Evaluation.create(evaluation_create_params)
      end
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def edit
    @evaluation = Evaluation.find_by(id: params[:id])
    if !@evaluation.present? || @evaluation.company_id != current_company.id
      redirect_to dashboard_path()
    else
      @poll = @evaluation.poll
      if @evaluation.is_submitted
        redirect_to evaluation_path()
      end
    end
  end

  def update
    @evaluation = Evaluation.find(params[:id])
    if @evaluation.present?
      if params[:commit] == "Evaluar"
        if current_company.is_confirmed
          params[:evaluation][:is_submitted] = true
          params[:evaluation][:submitted_date] = Time.current
          @evaluation.update(evaluation_update_params)
          @poll = Poll.find(@evaluation.poll_id)
          self.process_evaluation
          @notice = "Evaluación enviada"
        else
          @evaluation.update(evaluation_update_params)
          @notice = "Evaluación actualizada"
        end
      else
        @evaluation.update(evaluation_update_params)
        @notice = "Evaluación actualizada"
      end
    end
    respond_to do |format|
      format.turbo_stream
    end
    #redirect_to dashboard_path()
  end

  def show
    @evaluation = Evaluation.find_by(id: params[:id])
    if !@evaluation.present? || @evaluation.company_id != current_company.id
      redirect_to dashboard_path()
    else
      @poll = @evaluation.poll
      if @evaluation.is_submitted
        @print = false
        if params[:print].present?
          @print = true
        end
        self.process_evaluation
      else
        redirect_to edit_evaluation_path(@evaluation)
      end
    end
  end

  def process_evaluation
    sections = {}
    @total = 0
    @poll.poll_sections.joins(:section).order(:"section.weight").each do |ps|
      section = ps.section
      section_semaphore = ps.semaphore
      formula = section_semaphore.formula
      max_formula = section_semaphore.formula.dup
      ssemaphore = nil
      total = 0
      sections[section.id] = {
        color: section.color,
        title: section.title,
        description: section.description,
        questions: []
      }
      @poll.questions.where(section_id: section.id).order(:"poll_questions.question_weight").each do |question|
        eq = @evaluation.evaluation_questions.where(question_id: question.id ).first
        pq = @poll.poll_questions.where(question_id: question.id ).first
        color = nil
        semaphore_text = nil
        eqvalue = nil
        process = true
        case question.qtype
          when 'Numérica'
            max_value = 100
          when 'Opciones'
            max_value = question.options.order("ovalue desc").first.ovalue
          else
            process = false
        end
        if process
          if eq.present?
            eqvalue = eq.qvalue
            #Evaluate yellow/red for section
            if question.semaphore.green_value < eq.qvalue.to_i
              color = 'green'
              semaphore_text = question.semaphore.green_text
            elsif question.semaphore.red_value > eq.qvalue.to_i
              color = 'red'
              semaphore_text = question.semaphore.red_text
              if pq.section_red
                ssemaphore = ['red', section_semaphore.red_text]
              end
            else
              color = 'yellow'
              semaphore_text = question.semaphore.yellow_text
              if pq.section_yellow
                ssemaphore = ['yellow', section_semaphore.yellow_text]
              end
            end
          end
          sections[section.id][:questions].push({
            id: question.id,
            title: question.title,
            description: question.description,
            color: color,
            semaphore_text: semaphore_text,
            eqvalue: eqvalue
          })
          #Store max value
          #Replace value in formula
          max_formula.gsub!("[#{eq.question_id}]", "#{max_value.present? ? max_value : 0}")
          formula.gsub!("[#{eq.question_id}]", "#{eq.qvalue}")
          logger.debug("\n\nFORMULA\n#{formula}\n\n")
          logger.debug("\n\nMAX FORMULA\n#{max_formula}\n\n")
        end
      end
      #Evaluate formula
      #TODO ver cómo se evalúan las preguntas condicionales en la fórmula, por ahora se sustituyen con 0 (No puede ser multiplicador, sí suma o resta)
      formula.gsub!(/\[\d+\]/, "0")
      max_formula.gsub!(/\[\d+\]/, "0")
      total = eval formula
      max_total = eval max_formula
      sections[section.id][:total] = total
      #Add total to poll total
      logger.debug "\n\n SECTIONS SEMAPHORE\n#{section_semaphore.inspect}\n"
      @total += total.to_d*(section_semaphore.percentage.present? ? section_semaphore.percentage : 0)/max_total
      logger.debug("\n\nTOTAL\n#{@total}\n\n")
      #Calculate section semaphore if not seted by question
      if ssemaphore.nil?
        ssemaphore = self.semaphore(section_semaphore, total)
      end
      sections[section.id][:semaphore] = ssemaphore
    end
    if @evaluation.total.nil?
      @evaluation.update(total: @total)
    end
    @total = @total.to_i
    @sections = sections.values
  end
  #
  def semaphore(semaphore, value)
    if semaphore.green_value < value.to_i
      color = 'green'
      semaphore_text = semaphore.green_text
    elsif semaphore.red_value > value.to_i
      color = 'red'
      semaphore_text = semaphore.red_text
    else
      color = 'yellow'
      semaphore_text = semaphore.yellow_text
    end
    [color, semaphore_text]
  end
  #
  def evaluation_create_params
    params.require(:evaluation).permit(:company_id, :poll_id, :is_submitted, :submitted_date, evaluation_questions_attributes:[:question_id, :qvalue])
  end
  def evaluation_update_params
    params.require(:evaluation).permit(:is_submitted, :poll_id, :submitted_date, evaluation_questions_attributes:[:id, :question_id, :qvalue])
  end
end
