source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails'
gem 'mysql2'
gem 'puma'
gem 'bcrypt'
gem 'bootsnap'
gem 'active_model_serializers'
gem 'apipie-rails'
gem 'image_size'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rspec-json_matcher'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end
