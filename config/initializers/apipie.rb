Apipie.configure do |config|
  config.app_name                = "Mctsagsh"
  config.api_base_url            = "/v0"
  config.doc_base_url            = "/apipie"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.namespaced_resources    = true
  config.translate               = false
end
