class QuestionController < ApplicationController
  #before_action :authenticate
  #
  def get_options
    if params['question_id'].present?
      @question = Question.find(params['question_id'])
      logger.debug("\n\n QUESTION: \n #{@question.inspect}")
      respond_to do |format|
        format.turbo_stream
      end
    end
  end
  #
  def get_semaphore
    if params['question_id'].present?
      @question = Question.find(params['question_id'])
      logger.debug("\n\n QUESTION: \n #{@question.inspect}")
      respond_to do |format|
        format.turbo_stream
      end
    end
  end
  #
end
