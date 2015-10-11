Icewhistle::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false
  config.active_record.raise_in_transactional_callbacks = true
  # Log error messages when you accidentally call methods on nil.
  # config.whiny_nils = true
  config.eager_load = false
  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  # config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log
  # Do not compress assets
  config.assets.compress = false
  config.action_mailer.delivery_method = :letter_opener
  # Expands the lines which load the assets
  config.assets.debug = true
  # config.after_initialize do
  #   Bullet.enable = true
  #   Bullet.alert = true
  #   Bullet.bullet_logger = true
  #   Bullet.console = true
  #   Bullet.growl = false
  #   Bullet.rails_logger = true
  #   Bullet.disable_browser_cache = true
  # end 
  config.asset_host = Proc.new {|source|
    if source.starts_with?('/images') || source.starts_with?('/blogimage')
      "http://icewhistle.com"
    else
      "http://localhost:3000"
    end
    }
  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
end

