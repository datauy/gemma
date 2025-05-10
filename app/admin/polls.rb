ActiveAdmin.register Poll do
  # Specify parameters which should be permitted for assignment
  permit_params :title, :description, :area_id, :provision_id, :last_disclaimer, poll_questions_attributes:[:question_id, :question_weight, :poll_id, :_destroy, :id, :semaphore_id, :condition_question, :condition_operator, :condition_value, :section_yellow, :section_red], poll_sections_attributes:[:id, :section_id, :poll_id, :disabled, :_destroy, semaphore_attributes: [:id, :formula, :green_text, :green_value, :yellow_text, :red_text, :red_value, :_destroy]]

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
      div '', id: 'poll-form', data: {controller: "pollform", "pollform-target": 'form'} do
      #text_node javascript_include_tag "/gemma.js"
      f.semantic_errors(*f.object.errors.attribute_names)
      f.inputs do
        f.input :title, required: true
        f.input :description
        f.input :area, required: true
        f.input :provision, required: true
        f.input :last_disclaimer
      end
      questions = []
      condition_options = []
      div '', id: 'poll-sections' do
        text_node "<script>window.questions=[]; window.section={}; window.new_questions=[];</script>".html_safe
        if !f.object.new_record?
          logger.debug("\nQUESTIONS: #{f.object.questions.ids.to_json} \n\n\n")
          text_node "<script>window.questions=#{f.object.questions.ids.to_json};</script>".html_safe
          condition_options = f.object.questions.ids
        end
        isec = 0
        Section.all.order(:weight).each do |section|
          text_node "<script>window.section[#{section.id}]={questions:[]};</script>".html_safe
          div '', id: "poll-section-#{section.id}", class: "section" do
            render partial: 'poll/poll_admin_section', locals: { section: section, poll_id: f.object.id, isec: isec, sec: questions.length, condition_options: condition_options }
            isec += 1
            if !f.object.new_record?
              section_questions = Question.includes(:poll_questions).where(section_id: section.id, 'poll_questions.poll_id': f.object.id).pluck(:id)
              questions = questions | section_questions
            end
          end
        end
        #TODO: Section Semaphore (Evaluar el agregar sección)
      end
      div '', id: 'poll-add-section' do
        select_tag :add_section, options_for_select(Section.all.map {|s| [s.title, s.id]}),data: {action: 'change->polls#get_section'}
      end
      f.actions
    end
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
  member_action :foo, method: [:delete, :get] do
    puts "\n\nPASA MEMBER FOO\n\n"
    @tft = 'Turbo Frame for Button'
    #edirect_to collection_path, notice: "Imagen borrada"
  end
end
