ActiveAdmin.register Question do
  # Specify parameters which should be permitted for assignment
  menu priority: 4
  permit_params :qtype, :title, :description, :section, :section_id, :semaphore_id, options_attributes: [:title, :ovalue, :prefix, :sufix, :id, :_destroy, :otype], semaphore_attributes: [:green_text,:green_value,:yellow_text,:red_text,:red_value, :id, :_destroy]

  # or consider:
  #
  # permit_params do
  #   permitted = [:qtype, :title, :description, :section, :section_id, :semaphore_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  before_action :is_editable, only: [:edit, :update, :destroy]
  #
  controller do
    def is_editable
      #check evaluations for poll, Do not allow to edit if it has evaluations done
      logger.debug "\n\nEDIT QUESTION\n#{params[:id]}\n"
      if EvaluationQuestion.where(question_id: params[:id]).present?
        flash[:error] = "Ésta pregunta está siendo usada, consulte en las Evaluaciones que puedan estar usándola y elimínelas en caso de querer proceder."
        redirect_to action: :index
      end
    end
  end
  # Add or remove filters to toggle their visibility
  filter :id
  filter :qtype
  filter :title
  filter :description
  filter :section
  filter :created_at
  filter :updated_at
  filter :semaphore

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :qtype
    column :title
    column :description
    column :section
    column :created_at
    column :updated_at
    column :semaphore
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :qtype
      row :title
      row :description
      row :section
      row :created_at
      row :updated_at
      row :semaphore
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    inputs "", heading: false, class: "main-options" do
      f.inputs do
        f.input :qtype, label: "Tipo de pregunta", required: true, input_html: {data: {controller: 'question', action: 'change->question#filter_options'}}
        f.input :title, required: true
        f.input :description
        f.input :section_id, as: :select, input_html: {required: true}, include_blank: true, collection: Section.all.map { |s| [s.title, s.id] }
      end
    end
    #Todo: change for edit
    option_counter = 0
    f.inputs "", heading: false, id: "options-section" do
      f.has_many :options, heading: false, allow_destroy: true do |c|
        option_counter = option_counter + 1
        c.inputs "Opción #{option_counter}" do
        c.input :prefix, :label => "Prefijo", input_html: {class: 'options-prefix', rows: 1}
        c.input :title, label: false, input_html: {class: 'options-title'}
        c.input :ovalue, :label => "Valor", input_html: {class: 'options-value'}
        c.input :sufix, :label => "Sufijo", input_html: {class: 'options-sufix', rows: 1}
        c.input :otype, as: :hidden, input_html: {class: 'options-otype'}
      end
    end
    f.inputs "", heading: false, id: "semaphore-section", for: [:semaphore, f.object.semaphore || Semaphore.new] do |s|
      s.input :green_text, input_html: {placeholder: "Texto a mostrar si tiene este resultado", class: 'options-green', rows: 5}
      s.input :green_value, label: " > "
      s.input :yellow_text, input_html: {placeholder: "Texto a mostrar si tiene este resultado", class: 'options-yellow', rows: 5}
      s.input :red_text, input_html: {placeholder: "Texto a mostrar si tiene este resultado", class: 'options-red', rows: 5}
      s.input :red_value, label: " < "
    end
  end
    f.actions
  end
end
