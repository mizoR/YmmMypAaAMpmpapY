module RoutingSpecDefaultHost
  extend ActiveSupport::Concern

  included do
    around(:all) do |example|
      begin
        @__routing_spec_default_host__host = Rails.application.routes.default_url_options[:host]

        Rails.application.routes.default_url_options[:host] = 'mctsagsh.example.com'

        example.run
      ensure
        Rails.application.routes.default_url_options[:host] = @__routing_spec_default_host__host
      end
    end
  end
end
