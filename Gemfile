source "https://rubygems.org"

ruby "2.7.8"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bootsnap"
gem "puma"
gem "rails", "5.2.8.1"
gem "sass-rails", github: "rails/sass-rails"
gem "sqlite3", '~> 1.5.4'

gem "coffee-rails"
gem "jbuilder"
gem "turbolinks"
gem "uglifier"

gem "capistrano-rails", group: :development

gem "awesome_print"
gem "webpacker"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "capybara"
  gem "pry-rails"
  gem "pry-rescue"
  gem "rspec-rails"
  gem "rubocop"
  gem "selenium-webdriver"
end

group :development do
  gem "listen"
  gem "spring", '~> 2.1.1'
  gem "spring-commands-rspec"
  gem "spring-watcher-listen"
  gem "web-console"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
