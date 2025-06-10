class AdminMailer < ApplicationMailer
  default from: 'no-responder@data.org.uy'

  def new_company
    @company = params[:company]
    admins = AdminUser.all.pluck(:email)
    mail(to: admins, subject: "Gemma - Se ha creado una nueva Organización #{@company.fake_name}")
  end

end
