require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is NOT reloaded between requests in production.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings.
  config.eager_load = true

  # Full error reports are disabled for security reasons.
  config.consider_all_requests_local = false

  # Enable caching with Redis.
  config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'], expires_in: 1.day }

  # Serve static files from the `/public` directory.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Force SSL in production.
  config.force_ssl = true

  # Use Sidekiq for background jobs.
  config.active_job.queue_adapter = :sidekiq

  # Email configuration (Set your SMTP credentials in `credentials.yml.enc`).
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { host: "nurin.p.my" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    authentication: :plain,
    enable_starttls_auto: true,
    user_name: Rails.application.credentials.dig(:smtp, :user_name),
    password: Rails.application.credentials.dig(:smtp, :password)
  }
  config.action_mailer.deliver_later_queue_name = 'mailers'

  # Use log level from environment variable or default to :info.
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Preload app to optimize memory usage.
  config.preload_app = true

  # Prevent unnecessary logs in production.
  config.active_support.report_deprecations = false

  # Set allowed hosts for security.
  config.hosts << "nurin.p.my"

  # Do not dump schema after migrations in production.
  config.active_record.dump_schema_after_migration = false
end
