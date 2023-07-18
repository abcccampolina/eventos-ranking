require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EventosRanking
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.i18n.available_locales = 'pt-BR'
    config.i18n.default_locale = "pt-BR"
    config.time_zone = "Brasilia"
    config.public_file_server.enabled = true
    config.assets.precompile += %w( whateverasset|css|js )

    # Date
    Date::DATE_FORMATS[:default] = "%d/%m/%Y"

    # Time
    Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M"

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :test_unit, fixture: false
      g.stylesheets     false
      g.helper          :stimulus_scaffold
    end


    config.autoload_paths << Rails.root.join("lib")
    config.eager_load_paths << Rails.root.join("lib")

    config.action_view.field_error_proc = Proc.new do |html_tag, instance| 
      data_io =<<-HTML
        <div class="field_with_errors has-danger">#{html_tag}</div>
      HTML
      data_io.html_safe
    end

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "smtp.office365.com",
      port: 587,
      domain: "smtp.office365.com",
      user_name: "nao-responda@elevatech.com.br",
      password: "#Eleva2019!",
      authentication: :login,
      enable_starttls_auto: true,
    }


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
