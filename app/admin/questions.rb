ActiveAdmin.register Question do
  # Specify parameters which should be permitted for assignment
  permit_params :qtype, :title, :description, :section_id, options_attributes: [:title, :ovalue]

  # or consider:
  #
  # permit_params do
  #   permitted = [:qtype, :title, :description, :section]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :qtype
  filter :title
  filter :description
  filter :section
  filter :created_at
  filter :updated_at

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
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :qtype, input_html: {onchange: "question_type_change()"}
      f.input :title
      f.input :description
      f.input :section_id, as: :select, collection: Section.all.map { |s| [s.title, s.id] }
    end
    #Todo: change for edit
    inputs "Options", id: "input_Opciones", class: "options" do
      has_many :options, allow_destroy: true do |c|
        c.input :title, :label => "Etiqueta"
        c.input :ovalue, :label => "Valor"
        c.input :otype, as: :hidden, value: 1
      end
    end
    inputs "Numeric", id: "input_Numérica", class: "options"  do
      has_many :options, allow_destroy: true do |c|
        c.input :title, :label => "Etiqueta"
        c.input :ovalue, :label => "Valor"
        c.input :otype, as: :hidden, value: 2
      end
    end
    inputs "Text", id: "input_Texto",class: "options"  do
      has_many :options, allow_destroy: true do |c|
        c.input :title, :label => "Etiqueta"
        c.input :ovalue, :label => "Valor"
        c.input :otype, as: :hidden, value: 3
      end
    end
    inputs "Attachment", id: "input_Adjunto", class: "options"  do
      has_many :options, allow_destroy: true do |c|
        c.input :title, :label => "Etiqueta"
        c.input :ovalue, :label => "Valor"
        c.input :otype, as: :hidden, value: 4
      end
    end
    f.actions
    text_node javascript_include_tag "/gemma.js"
  end
end
