source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.19'
# Use Puma as the app server
gem 'puma', '~> 3.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# ENV based on application.yml
gem 'figaro'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rspec-retry'
end

group :development do
  gem 'listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
