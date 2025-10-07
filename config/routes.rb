Rails.application.routes.draw do
  devise_for :companies, :controllers => { registrations: 'companies/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "static_pages#home"

  #admin todo: agregar autentiación por defecto, en poll como admin.
  get "get_section_questions/:section_id" => 'poll#get_section_questions'
  get "add_section_question/:question_id" => 'poll#add_section_question'
  get "question/get_options/:question_id" => 'question#get_options'
  get "question/get_semaphore/:question_id" => 'question#get_semaphore'

  # Company pages
  get "dashboard" => 'companies#dashboard'
  get "company/get-poll/:area/:provision" => 'companies#get_poll'
  get "company/answer-poll" => 'companies#answer_poll'
  # Public pages
  get "sobre-el-proyecto" => "static_pages#about"
  get "planes" => "static_pages#pricing"
  get "export/:poll_id" => 'poll#export_evaluations', defaults: { format: :csv }

  resources :evaluations
end
