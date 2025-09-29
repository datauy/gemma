ActiveAdmin.register Evaluation do
  # Specify parameters which should be permitted for assignment
  permit_params :poll_id, :company_id, :is_submitted, :submitted_date

  # or consider:
  #
  # permit_params do
  #   permitted = [:poll_id, :company_id, :is_submitted, :submitted_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :poll
  filter :company
  filter :created_at
  filter :updated_at
  filter :is_submitted
  filter :submitted_date

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :poll
    column :company
    column "Ver Evaluacion" do |e|
      link_to "Ver Evaluacion", evaluation_path(e), target: "_blank"
    end
    column :created_at
    column :updated_at
    column :is_submitted
    column :submitted_date
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :poll
      row :company
      row :created_at
      row :updated_at
      row :is_submitted
      row :submitted_date
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :poll
      f.input :company
      f.input :is_submitted
      f.input :submitted_date
    end
    f.actions
  end
end
