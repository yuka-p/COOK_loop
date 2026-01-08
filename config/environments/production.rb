require "active_support/core_ext/integer/time"

Rails.application.configure do
  # --- 基本設定 ----------------------------------------------------

  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.force_ssl = true

  # --- アセット / ストレージ ---------------------------------------

  config.assets.compile = false
  config.active_storage.service = :local

  # --- ログ --------------------------------------------------------

  config.logger = ActiveSupport::TaggedLogging.new(
    ActiveSupport::Logger.new(STDOUT).tap do |logger|
      logger.formatter = ::Logger::Formatter.new
    end
  )

  config.log_tags  = [ :request_id ]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # --- I18n / ActiveRecord -----------------------------------------

  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # --- Action Mailer -------------------------------------

  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    user_name:            ENV["GMAIL_EMAIL"],
    password:             ENV["GMAIL_APP_PASSWORD"],
    authentication:       "plain",
    enable_starttls_auto: true
  }

  config.action_mailer.default_url_options = {
    host: "cook-loop.onrender.com",
    protocol: "https"
  }
end
