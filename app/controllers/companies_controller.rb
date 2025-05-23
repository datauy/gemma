class CompaniesController < ApplicationController
  before_action :authenticate_company!

  def dashboard
    logger.debug "COMPANY: #{current_company.inspect}"
    @company = current_company
  end
end
