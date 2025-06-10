class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # The path used after sign up.
  def after_sign_in_path_for(resource)
    if resource.class.name == "Company"
      if resource.is_main_company
        dashboard_path
      else
        if resource.evaluations.length > 0
          dashboard_path
        else
          company_answer_poll_path
        end
      end
    else
      super(resource)
    end
  end
  #
end
