# frozen_string_literal: true

SolidusCms.configure do |config|
  # Adds a new menu item to the Solidus backend
  if SolidusSupport.backend_available?
    Spree::Backend::Config.configure do |c|
      c.menu_items << Spree::BackendConfiguration::MenuItem.new(
        [:pages_builder],
        'file',
        url: '/admin/custom_pages',
        condition: -> { can?(:admin, SolidusCms::Page) }
      )
    end

    config.backend_controller_parent = 'Spree::Admin::ResourceController'
  end

  # Adds a new menu item to the Solidus Admin
  SolidusAdmin::Config.configure do |config|
    config.menu_items << {
      key: :page_builder,
      route: -> { spree.admin_custom_pages_path },
      position: 80,
      icon: 'file-line',
    }
  end

  # Changes the default layout for custom pages
  # config.layout = 'custom_layout'

  # You can override the parent class used by SolidusCms controllers here.
  # This is useful to leverage auth mechanisms, hooks and other behaviors from the main app.
  config.frontend_controller_parent = 'StoreController'
  config.backend_controller_parent = 'SolidusAdmin::ResourcesController'
end
