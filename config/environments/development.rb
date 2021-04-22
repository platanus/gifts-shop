
Rails.application.configure do
  config.active_job.queue_adapter = :async
  config.action_mailer.default_url_options = { host: ENV.fetch("APPLICATION_HOST") }
  config.action_mailer.default_options = { from: ENV['DEFAULT_EMAIL_ADDRESS'] }
  config.cache_classes = false
  config.eager_load = false
  config.action_mailer.asset_host = "http://#{ENV.fetch('APPLICATION_HOST')}"
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.delivery_method = :sendgrid_dev
  config.action_mailer.sendgrid_dev_settings = {
    api_key: ENV.fetch('SENDGRID_API_KEY')
  }
  config.consider_all_requests_local = true
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end
  config.active_storage.service = :local
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.assets.debug = true
  config.assets.quiet = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
