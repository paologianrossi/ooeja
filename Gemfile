source "https://rubygems.org"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby "2.3.1"
gem "rails", "~> 5.0"
gem "puma", "~> 3.8"
gem "sass-rails", "~> 5.0"
gem "uglifier", "~> 3.1"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails", "~> 4.2"
gem "turbolinks", "~> 5.0"
gem "jbuilder", "~> 2.6"
gem "acts-as-taggable-on", "~> 4.0"
gem "pry-rails", "~> 0.3"
gem "awesome_print", "~> 1.7"
gem "pismo", "~> 0.7"
gem "bcrypt", "~> 3.1"
gem "jwt", "~> 1.5"
gem "simple_command", "~> 0.0"
gem "font-awesome-rails", "~> 4.7"

group :development, :test do
  gem "byebug", "~> 9.0", platform: :mri
end

group :development do
  gem "web-console", "~> 3.4"
  gem "listen", "~> 3.0"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
end
gem "tzinfo-data", "~> 1.2017", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "bootstrap-sass", "~> 3.3"
gem "high_voltage", "~> 3.0"
gem "pg", "~> 0.20"
gem "slim-rails", "~> 3.1"
group :development do
  gem "better_errors", "~> 2.1"
  gem "guard-bundler", "~> 2.1"
  gem "guard-rails", "~> 0.8"
  gem "guard-rspec", "~> 4.7"
  gem "rails_layout", "~> 1.0"
  gem "rb-fchange", "~> 0.0", :require=>false
  gem "rb-fsevent", "~> 0.9", :require=>false
  gem "rb-inotify", "~> 0.9", :require=>false
  gem "spring-commands-rspec", "~> 1.0"
end
group :development, :test do
  gem "factory_girl_rails", "~> 4.8"
  gem "faker", "~> 1.7"
  gem "rspec-rails", "~> 3.5"
end
group :test do
  gem "capybara", "~> 2.12"
  gem "database_cleaner", "~> 1.5"
  gem "launchy", "~> 2.4"
  gem "selenium-webdriver", "~> 3.3"
end
