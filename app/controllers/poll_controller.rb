class PollController < ApplicationController

  def get_section_questions
    @questions = []
    @section_id = "0"
    @poll_id = 0
    if params[:section_id].present?
      not_in = []
      if params[:poll_id].present?
        @poll_id = params[:poll_id]
        not_in = Question.includes(:polls).where('polls.id': params[:poll_id]).pluck(:id)
      end
      @section_id = params[:section_id]
      @questions = Question.where( section_id: params[:section_id] ).where.not(id: not_in).order(:title).pluck(:title, :id)
    end
    respond_to do |format|
      format.turbo_stream
    end
  end
  def add_section_question
    if params[:question_id].present? && params[:qqtty].present? && params[:section_id].present?
      @question = Question.find(params[:question_id])
      @poll_id = params[:poll_id]
      @qqtty = params[:qqtty]
      @section_id = params[:section_id]
      @isec = params[:isec]
      @sqtty = params[:sqtty]
    else
      @error = 'Invalid parameters'
    end
    respond_to do |format|
      format.turbo_stream
    end
  end
  def export_evaluations
    if !current_admin_user
      redirect_to dashboard_path()
    else
      resource = Poll.find(params[:poll_id])
      @headers = ['ID', 'ID Organización', 'Nombre de Organización', 'Fecha de envío', 'TOTAL']
      resource.questions.order(:id).each do |q|
        @headers.push("#{q.id} - #{q.title}")
      end
      @lines = []
      resource.evaluations.each do |e|
        company = Company.find(e.company_id)
        line = [e.id, e.company_id, company.name, e.submitted_date, e.total]
        e.evaluation_questions.order(:question_id).each do |eq|
          eq.qvalue.nil ? line.push("Sin respuesta") : line.push(eq.qvalue)
        end
        @lines.push(line)
      end
      respond_to do |format|
        format.csv do
          response.headers['Content-Type'] = 'text/csv'
          response.headers['Content-Disposition'] = "attachment; filename=evaluations-poll##{resource.id}-#{Date.today.to_s}.csv"
          render template: "poll/evaluations"
        end
      end
    end
  end
end
