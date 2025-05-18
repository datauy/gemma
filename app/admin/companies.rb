ActiveAdmin.register Company do
  # Specify parameters which should be permitted for assignment
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :fake_name, :state, :address, :activity, :size, :man_workers, :woman_workers, :start_year, :contact_name, :contact_position, :contact_tel, :contact_email, :is_confirmed, :is_main_company, :password

  # or consider:
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :fake_name, :state, :address, :activity, :size, :man_workers, :woman_workers, :start_year, :contact_name, :contact_position, :contact_tel, :contact_email, :is_confirmed, :is_main_company]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :email
  filter :encrypted_password
  filter :reset_password_token
  filter :reset_password_sent_at
  filter :remember_created_at
  filter :created_at
  filter :updated_at
  filter :name
  filter :fake_name
  filter :state
  filter :address
  filter :activity
  filter :size
  filter :man_workers
  filter :woman_workers
  filter :start_year
  filter :contact_name
  filter :contact_position
  filter :contact_tel
  filter :contact_email
  filter :is_confirmed
  filter :is_main_company

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :fake_name
    column :state
    column :address
    column :activity
    column :size
    column :man_workers
    column :woman_workers
    column :start_year
    column :contact_name
    column :contact_position
    column :contact_tel
    column :contact_email
    column :is_confirmed
    column :is_main_company
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :email
      row :name
      row :fake_name
      row :state
      row :address
      row :activity
      row :size
      row :man_workers
      row :woman_workers
      row :start_year
      row :contact_name
      row :contact_position
      row :contact_tel
      row :contact_email
      row :is_confirmed
      row :is_main_company
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :email
      f.input :password
      f.input :name
      f.input :fake_name
      f.input :state
      f.input :address
      f.input :activity
      f.input :size
      f.input :man_workers
      f.input :woman_workers
      f.input :start_year
      f.input :contact_name
      f.input :contact_position
      f.input :contact_tel
      f.input :contact_email
      f.input :is_confirmed
      f.input :is_main_company
      if f.object.new_record?
        f.input :companies, as: :check_boxes, collection: Company.where(is_main_company: true)
      else
        f.input :companies, as: :check_boxes, collection: Company.where(is_main_company: true).where.not(id: f.object.id)
      end
    end
    f.actions
  end

  controller do
    #Allow blank pass, not to change
    def update
      if params[:company][:password].blank? && params[:company][:password_confirmation].blank?
        params[:company].delete("password")
        params[:company].delete("password_confirmation")
      end
      super
    end
  end
end
