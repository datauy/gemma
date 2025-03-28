ActiveAdmin.register Poll do
  # Specify parameters which should be permitted for assignment
  permit_params :title, :description, :area_id, :provision_id, :last_disclaimer, poll_questions_attributes:[:question_id, :_destroy, :id]

  # or consider:
  #
  # permit_params do
  #   permitted = [:title, :description, :area_id, :provision_id, :last_disclaimer]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :title
  filter :description
  filter :area
  filter :provision
  filter :last_disclaimer
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :title
    column :description
    column :area
    column :provision
    column :last_disclaimer
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :title
      row :description
      row :area
      row :provision
      row :last_disclaimer
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :title
      f.input :description
      f.input :area
      f.input :provision
      f.input :last_disclaimer
    end
    #Todo: change for edit
    has_many :poll_questions, allow_destroy: true do |q|
      q.input :question_id, label: "Pregunta", as: :searchable_select, collection: Question.all.map{|s| [s.title, s.id]}
    end
    #f.object.new_record?
    f.actions
  end
  before_save do |object|
    #params[:organization][:zone_ids].reject! { |c| c.empty? }
    #params[:organization][:subject_ids].reject! { |c| c.empty? }
    #params[:poll][:poll_questions_attributes].reject! { |i, param| param["question_id"].empty? }
    #params[:poll][:poll_questions_attributes].each do |i, param|
      #param["poll_id"] = param["id"]
      #params[:poll][:poll_questions_attributes][i].reject! { |k| k == 'id' }
    #end
    logger.debug "\nBEFORE SAVE RESOURCE\n #{params[:poll].inspect}\n\n"
    #super
  end
end
