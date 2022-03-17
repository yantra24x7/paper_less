Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false


  ENV['AWS_ACCESS_KEY_ID'] = "AKIATTZQDNTEPYV2PDXD" #"AKIA2OV2OB5YMA6JOW3I" # Rails.application.credentials.aws_credentials[:access_key_id]  # "AKIA2OV2OB5YMA6JOW3I"
  ENV['AWS_SECRET_ACCESS_KEY'] = "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" # "09xUQ+sUpaptL2+LB0DuBAFWrUuwWUiIWT0dYuXp" # Rails.application.credentials.aws_credentials[:secret_access_key] # "09xUQ+sUpaptL2+LB0DuBAFWrUuwWUiIWT0dYuXp"
  ENV['S3_BUCKET'] = "generalpaper" # Rails.application.credentials.aws_credentials[:bucket_name] # "bc4"
  ENV['S3_REGION'] = "ap-south-1" # Rails.application.credentials.aws_credentials[:region] # "ap-south-1" 


  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log


  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
