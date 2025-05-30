class CompaniesController < ApplicationController
  before_action :authenticate_company!

  def dashboard
    logger.debug "COMPANY: #{current_company.inspect}"
    @company = current_company
  end
  #Answer page
  def answer_poll


  end
  #Turbo to get poll by filters
  def get_poll
    @poll = Poll.where( area_id: params[:area], provision_id: params[:provision], enabled: true ).first
    @evaluation = Evaluation.new
    respond_to do |format|
      format.turbo_stream
    end
  end
end
