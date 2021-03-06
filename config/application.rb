# Put this in config/application.rb
require File.expand_path('../boot', __FILE__)
require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Icewhistle
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  
    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{RAILS_ROOT}/extras )
  
    # Specify gems that this application depends on and have them installed with rake gems:install
    # config.gem "bj"
    # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
    # config.gem "sqlite3-ruby", :lib => "sqlite3"
    # config.gem "aws-s3", :lib => "aws/s3"
  
    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
  
    # Skip frameworks you're not going to use. To use Rails without a database,
    # you must remove the Active Record framework.
    # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
    config.action_mailer.delivery_method = :smtp
    config.i18n.default_locale = :'en-GB'
    config.action_mailer.smtp_settings = {
      :address => 'mail.cenotaph.org',
      :port => 587,
     :domain => 'cenotaph.org',
    :authentication => "plain",
    :user_name => 'john@cenotaph.org',
  	:password => ENV['MAIL_PASSWORD'],
  	:enable_starttls_auto => false
  }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.assets.enabled = true
  # config.action_mailer.default_charset = 'utf-8'

  config.time_zone = 'Helsinki'
  config.active_record.default_timezone = :local
  config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'UTC'
  
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    # config.i18n.default_locale = :de
  end
end
