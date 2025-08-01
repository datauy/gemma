# frozen_string_literal: true

class Companies::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :fake_name, :registration_number, :logo, :state, :address, :activity, :size, :man_workers, :woman_workers, :start_year, :contact_name, :contact_position, :contact_tel, :contact_email, :is_confirmed, :is_main_company, :password])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :fake_name, :registration_number, :logo, :state, :address, :activity, :size, :man_workers, :woman_workers, :start_year, :contact_name, :contact_position, :contact_tel, :contact_email, :is_confirmed, :is_main_company, :password, main_company_ids:[]])
  end

  # The path used after sign up.
  #def after_sign_up_path_for(resource)
  #  super(resource)
  #end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
