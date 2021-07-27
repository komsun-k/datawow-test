source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Only define Ruby version once (i.e. for Heroku)
version_file = File.join(File.dirname(__FILE__), '.ruby-version')
ruby File.read(version_file).strip

# Backend
gem 'rails', '~> 6.1.4' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'pg', '~> 1.1' # Use postgresql as the database for Active Record
gem 'puma', '~> 5.0' # Use Puma as the app server
gem 'jbuilder', '~> 2.7' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'bootsnap', '>= 1.4.4', require: false # Reduces boot times through caching; required in config/boot.rb

# Frontend
gem 'webpacker', '~> 5.0' # Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'turbolinks', '~> 5' # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'sass-rails', '>= 6' # Use SCSS for stylesheets
gem 'autoprefixer-rails' # Automatically add vendor prefixes to CSS rules

group :production do
  gem 'heroku-deflater' # A simple rack middleware that enables compressing of your sprockets and webpacker assets and application responses on Heroku
  gem 'rack-timeout' # Abort requests that are taking too long; an exception is raised
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'foreman'
  gem 'bullet' # Warn about n+1 queries and unused includes
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'yard' # Documentation
end

group :development do
  gem 'web-console', '>= 4.1.0' # Access an interactive console on exception pages or by calling 'console' anywhere in the code.

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers'
  gem 'rexml', '~> 3.2', '>= 3.2.5' # An XML toolkit for Ruby. REXML supports both tree and stream document parsing.
end
