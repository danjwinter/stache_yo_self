# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

def json_response
  @json_response ||= JSON.parse(response.body, symbolize_names: true)
end

def simulated_slack_slash_stache_me
  {"token"=>ENV['SLACK_SLASH_TOKEN'],
   "team_id"=>"T029P2S9M",
   "team_domain"=>"turingschool",
   "channel_id"=>"C0PQ0FVJ8",
   "channel_name"=>"test-mustache",
   "user_id"=>"U09UB1KCN",
   "user_name"=>"dan.winter",
   "command"=>"/stache_me",
   "text"=>"",
   "response_url"=>"https://hooks.slack.com/commands/T029P2S9M/24662857762/cxyEwotsjSykD2OLnshQMtNk",
   "formats"=>{"default"=>:json},
   "controller"=>"stache_me",
   "action"=>"show"}
 end
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.before(:suite) do
     DatabaseCleaner.clean_with(:truncation)
   end

   config.before(:each) do
     DatabaseCleaner.strategy = :transaction
   end

   config.before(:each, :js => true) do
     DatabaseCleaner.strategy = :truncation
   end

   config.before(:each) do
     DatabaseCleaner.start
   end

   config.after(:each) do
     DatabaseCleaner.clean
   end
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:slack] = OmniAuth::AuthHash.new(
  {"provider"=>"slack",
 "uid"=>"U09UB1KCN",
 "info"=>
  {"nickname"=>"dan.winter",
   "team"=>"Turing",
   "user"=>"dan.winter",
   "team_id"=>"T029P2S9M",
   "user_id"=>"U09UB1KCN",
   "name"=>"Dan Winter",
   "email"=>"dan.j.winter@gmail.com",
   "first_name"=>"Dan",
   "last_name"=>"Winter",
   "description"=>"",
   "image_24"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_24.jpg",
   "image_48"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_48.jpg",
   "image"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_192.jpg",
   "team_domain"=>"turingschool",
   "is_admin"=>false,
   "is_owner"=>false,
   "time_zone"=>"America/Indiana/Indianapolis"},
 "credentials"=>{"token"=>ENV["MY_TOKEN"], "expires"=>false},
 "extra"=>
  {"raw_info"=>{"ok"=>true, "url"=>"https://turingschool.slack.com/", "team"=>"Turing", "user"=>"dan.winter", "team_id"=>"T029P2S9M", "user_id"=>"U09UB1KCN"},
   "web_hook_info"=>{},
   "bot_info"=>{},
   "user_info"=>
    {"ok"=>true,
     "user"=>
      {"id"=>"U09UB1KCN",
       "team_id"=>"T029P2S9M",
       "name"=>"dan.winter",
       "deleted"=>false,
       "status"=>nil,
       "color"=>"5a4592",
       "real_name"=>"Dan Winter",
       "tz"=>"America/Indiana/Indianapolis",
       "tz_label"=>"Eastern Standard Time",
       "tz_offset"=>-18000,
       "profile"=>
        {"first_name"=>"Dan",
         "last_name"=>"Winter",
         "image_24"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_24.jpg",
         "image_32"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_32.jpg",
         "image_48"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_48.jpg",
         "image_72"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_72.jpg",
         "image_192"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_192.jpg",
         "image_512"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_512.jpg",
         "image_1024"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_1024.jpg",
         "image_original"=>"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_original.jpg",
         "avatar_hash"=>"8e0c5fc47896",
         "title"=>"",
         "phone"=>"",
         "skype"=>"",
         "real_name"=>"Dan Winter",
         "real_name_normalized"=>"Dan Winter",
         "email"=>"dan.j.winter@gmail.com"},
       "is_admin"=>false,
       "is_owner"=>false,
       "is_primary_owner"=>false,
       "is_restricted"=>false,
       "is_ultra_restricted"=>false,
       "is_bot"=>false,
       "has_2fa"=>false}},
   "team_info"=>
    {"ok"=>true,
     "team"=>
      {"id"=>"T029P2S9M",
       "name"=>"Turing",
       "domain"=>"turingschool",
       "email_domain"=>"turing.io",
       "icon"=>
        {"image_34"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2015-01-27/3533055149_7c3a5d727b08de08d48e_34.jpg",
         "image_44"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2015-01-27/3533055149_7c3a5d727b08de08d48e_44.jpg",
         "image_68"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2015-01-27/3533055149_7c3a5d727b08de08d48e_68.jpg",
         "image_88"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2015-01-27/3533055149_7c3a5d727b08de08d48e_88.jpg",
         "image_102"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2015-01-27/3533055149_7c3a5d727b08de08d48e_102.jpg",
         "image_132"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2015-01-27/3533055149_7c3a5d727b08de08d48e_132.jpg",
         "image_original"=>"https://s3-us-west-2.amazonaws.com/slack-files2/avatars/2015-01-27/3533055149_7c3a5d727b08de08d48e_original.jpg"}}}}})
end
