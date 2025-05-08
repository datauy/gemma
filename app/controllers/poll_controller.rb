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
end
