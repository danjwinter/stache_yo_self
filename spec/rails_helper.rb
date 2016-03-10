# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'typhoeus/adapters/faraday'


class FakeImage
  def url
    "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_512.jpg"
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock, :typhoeus
  c.allow_http_connections_when_no_cassette = true
end

def json_response
  @json_response ||= JSON.parse(response.body, symbolize_names: true)
end

def stubbed_face_plus_plus_json_response
  {:face=>
  [{:attribute=>{:age=>{:range=>12, :value=>32}, :gender=>{:confidence=>99.5658, :value=>"Male"}, :race=>{:confidence=>97.4503, :value=>"White"}, :smiling=>{:value=>5.39037}},
    :face_id=>"88b8e48125db32de64a88ca6e9b80e13",
    :position=>
     {:center=>{:x=>52.734375, :y=>42.578125},
      :eye_left=>{:x=>45.326563, :y=>36.760156},
      :eye_right=>{:x=>59.900195, :y=>36.137305},
      :height=>30.078125,
      :mouth_left=>{:x=>47.554297, :y=>52.6875},
      :mouth_right=>{:x=>59.465039, :y=>51.795703},
      :nose=>{:x=>53.956445, :y=>44.94668},
      :width=>30.078125},
    :tag=>""}]}
end

def stubbed_slack_omniauth_response
  {:ok=>true,
 :access_token=> ENV['SAMPLE_SLACK_ACCESS_TOKEN'],
 :scope=>
  "identify,commands,channels:read,team:read,users:read,chat:write:user,chat:write:bot,bot",
 :team_name=>"Turing",
 :team_id=>"T029P2S9M"}
end

def stubbed_slack_user_info_json_response
  {:ok=>true,
 :user=>
  {:id=>"U09UB1KCN",
   :team_id=>"T029P2S9M",
   :name=>"dan.winter",
   :deleted=>false,
   :status=>nil,
   :color=>"5a4592",
   :real_name=>"Dan Winter",
   :tz=>"America/Indiana/Indianapolis",
   :tz_label=>"Eastern Standard Time",
   :tz_offset=>-18000,
   :profile=>
    {:first_name=>"Dan",
     :last_name=>"Winter",
     :image_24=>
      "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_24.jpg",
     :image_32=>
      "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_32.jpg",
     :image_48=>
      "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_48.jpg",
     :image_72=>
      "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_72.jpg",
     :image_192=>
      "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_192.jpg",
     :image_512=>
      "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_512.jpg",
     :image_1024=>
      "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_1024.jpg",
     :image_original=>
      "https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_original.jpg",
     :avatar_hash=>"8e0c5fc47896",
     :title=>"",
     :phone=>"",
     :skype=>"",
     :real_name=>"Dan Winter",
     :real_name_normalized=>"Dan Winter",
     :email=>"dan.j.winter@gmail.com"},
   :is_admin=>false,
   :is_owner=>false,
   :is_primary_owner=>false,
   :is_restricted=>false,
   :is_ultra_restricted=>false,
   :is_bot=>false,
   :has_2fa=>false}}
end
#
# def stubbed_face_plus_plus_body
#   "{\n\"face\": [\n{\n\"attribute\": {\n\"age\": {\n\"range\": 12, \n\"value\": 32\n}, \n
# \"gender\": {\n\"confidence\": 99.5658, \n\"value\": \"Male\"\n}, \n\"race\": {\n\"
# confidence\": 97.4503, \n\"value\": \"White\"\n}, \n\"smiling\": {\n\"value\": 5.39037\n}\n}, \n\"face_id\": \"c33d82e5f5791fd6918745e2fd94281b\", \n\"position\": {\n\"center\": {\n\"x\": 52.734375, \n\"y\": 42.578125\n}, \n\"eye_left\": {\n\"x\": 45.326563, \n\"y\": 36.760156\n}, \n\"eye_right\": {\n\"x\": 59.900195, \n\"y\": 36.137305\n}, \n\"height\": 30.078125, \n'mouth_left': {\n'x': 47.554297, \n\"y\": 52.6875\n                }, \n                \"mouth_right\": {\n                    \"x\": 59.465039, \n                    \"y\": 51.795703\n                }, \n                \"nose\": {\n                    \"x\": 53.956445, \n                    \"y\": 44.94668\n                }, \n                \"width\": 30.078125\n            }, \n            \"tag\": \"\"\n        }\n    ], \n    \"img_height\": 512, \n    \"img_id\": \"92ec35e1ce96dc31d4cbbfdcbc129c2b\", \n    \"img_width\": 512, \n    \"session_id\": \"f3fe6f7618c648d5995ace12a96dca0e\", \n    \"url\": \"https://avatars.slack-edge.com/2016-03-01/23827508289_8e0c5fc47896904c9086_512.jpg\"\n}"
# end

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

  config.include FactoryGirl::Syntax::Methods

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

end
