ActiveAdmin.importmap.draw do
  pin "@rails/actioncable", to: "actioncable.esm.js", preload: true
  pin "@rails/activestorage", to: "activestorage.esm.js", preload: true

  pin "@hotwired/turbo-rails", to: "turbo.js", preload: true
  pin "@hotwired/stimulus", to: "stimulus.js", preload: true
  pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

  pin "application", preload: true
  pin_all_from "app/javascript/controllers", under: "controllers"
  pin "trix"
  pin "@rails/actiontext", to: "actiontext.esm.js"
  pin 'active_admin_custom', to: 'active_admin_custom.js'
end

ActiveAdmin.setup do |config|
  # == Site Title
  #
  # Set the title that is displayed on the main layout
  # for each of the active admin pages. Can also be customized
  # by extracting the _site_header partial into your project
  # to use your own logo, styles, etc.
  #
  config.site_title = "Gemma"

  # == Load Paths
  #
  # By default Active Admin files go inside app/admin/.
  # You can change this directory.
  #
  # eg:
  #   config.load_paths = [File.join(Rails.root, 'app', 'ui')]
  #
  # Or, you can also load more directories.
  # Useful when setting namespaces with users that are not your main AdminUser entity.
  #
  # eg:
  #   config.load_paths = [
  #     File.join(Rails.root, 'app', 'admin'),
  #     File.join(Rails.root, 'app', 'cashier')
  #   ]

  # == Default Namespace
  #
  # Set the default namespace each administration resource
  # will be added to.
  #
  # eg:
  #   config.default_namespace = :hello_world
  #
  # This will create resources in the HelloWorld module and
  # will namespace routes to /hello_world/*
  #
  # To set no namespace by default, use:
  #   config.default_namespace = false
  #
  # Default:
  # config.default_namespace = :admin
  #
  # You can customize the settings for each namespace by using
  # a namespace block. For example, to change the site title
  # within a namespace:
  #
  #   config.namespace :admin do |admin|
  #     admin.site_title = "Custom Admin Title"
  #   end
  #
  # This will ONLY change the title for the admin section. Other
  # namespaces will continue to use the main "site_title" configuration.

  # == User Authentication
  #
  # Active Admin will automatically call an authentication
  # method in a before filter of all controller actions to
  # ensure that there is a currently logged in admin user.
  #
  # This setting changes the method which Active Admin calls
  # within the application controller.
  config.authentication_method = :authenticate_admin_user!

  # == User Authorization
  #
  # Active Admin will automatically call an authorization
  # method in a before filter of all controller actions to
  # ensure that there is a user with proper rights. You can use
  # CanCanAdapter, PunditAdapter, or make your own. Please
  # refer to the documentation.
  # config.authorization_adapter = ActiveAdmin::CanCanAdapter
  # config.authorization_adapter = ActiveAdmin::PunditAdapter

  # In case you prefer Pundit over other solutions you can here pass
  # the name of default policy class. This policy will be used in every
  # case when Pundit is unable to find suitable policy.
  # config.pundit_default_policy = "MyDefaultPunditPolicy"

  # If you wish to maintain a separate set of Pundit policies for admin
  # resources, you may set a namespace here that Pundit will search
  # within when looking for a resource's policy.
  # config.pundit_policy_namespace = :admin

  # You can customize your CanCan Ability class name here.
  # config.cancan_ability_class = "Ability"

  # You can specify a method to be called on unauthorized access.
  # This is necessary in order to prevent a redirect loop which happens
  # because, by default, user gets redirected to Dashboard. If user
  # doesn't have access to Dashboard, he'll end up in a redirect loop.
  # Method provided here should be defined in application_controller.rb.
  # config.on_unauthorized_access = :access_denied

  # == Current User
  #
  # Active Admin will associate actions with the current
  # user performing them.
  #
  # This setting changes the method which Active Admin calls
  # (within the application controller) to return the currently logged in user.
  config.current_user_method = :current_admin_user

  # == Logging Out
  #
  # Active Admin displays a logout link on each screen. These
  # settings configure the location and method used for the link.
  #
  # This setting changes the path where the link points to. If it's
  # a string, the string is used as the path. If it's a Symbol, we
  # will call the method to return the path.
  #
  # Default:
  config.logout_link_path = :destroy_admin_user_session_path

  # == Root
  #
  # Set the action to call for the root path. You can set different
  # roots for each namespace.
  #
  # Default:
  # config.root_to = 'dashboard#index'

  # == Admin Comments
  #
  # This allows your users to comment on any resource registered with Active Admin.
  #
  # You can completely disable comments:
  # config.comments = false
  #
  # You can change the name under which comments are registered:
  # config.comments_registration_name = 'AdminComment'
  #
  # You can change the order for the comments and you can change the column
  # to be used for ordering:
  # config.comments_order = 'created_at ASC'
  #
  # You can disable the menu item for the comments index page:
  # config.comments_menu = false
  #
  # You can customize the comment menu:
  # config.comments_menu = { parent: 'Admin', priority: 1 }

  # == Batch Actions
  #
  # Enable and disable Batch Actions
  #
  config.batch_actions = true

  # == Controller Filters
  #
  # You can add before, after and around filters to all of your
  # Active Admin resources and pages from here.
  #
  # config.before_action :do_something_awesome

  # == Attribute Filters
  #
  # You can exclude possibly sensitive model attributes from being displayed,
  # added to forms, or exported by default by ActiveAdmin
  #
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]

  # == Localize Date/Time Format
  #
  # Set the localize format to display dates and times.
  # To understand how to localize your app with I18n, read more at
  # https://guides.rubyonrails.org/i18n.html
  #
  # You can run `bin/rails runner 'puts I18n.t("date.formats")'` to see the
  # available formats in your application.
  #
  config.localize_format = :long

  # == Removing Breadcrumbs
  #
  # Breadcrumbs are enabled by default. You can customize them for individual
  # resources or you can disable them globally from here.
  #
  # config.breadcrumb = false

  # == Create Another Checkbox
  #
  # Create another checkbox is disabled by default. You can customize it for individual
  # resources or you can enable them globally from here.
  #
  # config.create_another = true

  # == CSV options
  #
  # Set the CSV builder separator
  # config.csv_options = { col_sep: ';' }
  #
  # Force the use of quotes
  # config.csv_options = { force_quotes: true }

  # == Menu System
  #
  # You can add a navigation menu to be used in your application, or configure a provided menu
  #
  # If you wanted to add a static menu item to the default menu provided:
  #
  #   config.namespace :admin do |admin|
  #     admin.build_menu :default do |menu|
  #       menu.add label: "My Great Website", url: "https://mygreatwebsite.example.com", html_options: { target: "_blank" }
  #     end
  #   end

  # == Download Links
  #
  # You can disable download links on resource listing pages,
  # or customize the formats shown per namespace/globally
  #
  # To disable/customize for the :admin namespace:
  #
  #   config.namespace :admin do |admin|
  #
  #     # Disable the links entirely
  #     admin.download_links = false
  #
  #     # Only show XML & PDF options. You must register the format mime type with `Mime::Type.register`.
  #     admin.download_links = [:xml, :pdf]
  #
  #     # Enable/disable the links based on block (for example, with cancan)
  #     admin.download_links = proc { can?(:view_download_links) }
  #
  #   end

  # == Pagination
  #
  # Pagination is enabled by default for all resources.
  # You can control the default per page count for all resources here.
  #
  # config.default_per_page = 30
  #
  # You can control the max per page count too.
  #
  # config.max_per_page = 10_000

  # == Filters
  #
  # By default the index screen includes a "Filters" sidebar on the right
  # hand side with a filter for each attribute of the registered model.
  # You can enable or disable them for all resources here.
  #
  # config.filters = true
  #
  # By default the filters include associations in a select, which means
  # that every record will be loaded for each association (up
  # to the value of config.maximum_association_filter_arity).
  # You can enabled or disable the inclusion
  # of those filters by default here.
  #
  # config.include_default_association_filters = true

  # config.maximum_association_filter_arity = 256 # default value of :unlimited will change to 256 in a future version
  # config.filter_columns_for_large_association = [
  #    :display_name,
  #    :full_name,
  #    :name,
  #    :username,
  #    :login,
  #    :title,
  #    :email,
  #  ]
  # config.filter_method_for_large_association = '_start'

  # == Sorting
  #
  # By default ActiveAdmin::OrderClause is used for sorting logic
  # You can inherit it with own class and inject it for all resources
  #
  # config.order_clause = MyOrderClause
end
