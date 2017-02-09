require 'sinatra'
require 'rubygems'
require 'sinatra/activerecord'
require "./configs/settings.rb"

cwd = File.dirname(__FILE__)

configure do
  #set :layout, :'layout/pjax'
  set :public_folder, Proc.new { File.join(root, "public") }
  set :environment, $SETTINGS[:environment]
  set :views, Proc.new { File.join(root, "app", "views") }
  set :sessions, true
  set :show_exceptions, :after_handler
  set :lock, true
end

use Rack::Session::Cookie, :key => 'skeleton.session',
                           :path => '/',
                           :expire_after => 10800, #3h
                           :secret => '12345678901234567890'
# DB Configuration
ActiveRecord::Base.establish_connection $SETTINGS[:active_record]
ActiveRecord::Base.include_root_in_json = false

if c = ActiveRecord::Base.connection
  # see http://www.sqlite.org/pragma.html for details
  # Journal mode for database, WAL=write-ahead log
  # c.execute 'PRAGMA main.journal_mode=WAL;'
end

# Load all models
Dir["#{cwd}/app/models/*.rb"].each { |file| require file }

# Load all controllers
Dir["#{cwd}/app/routes/*.rb"].each { |file| require file }

# Load all custom error pages
Dir["#{cwd}/app/errors/*.rb"].each { |file| require file }

# Load all libraries
Dir["#{cwd}/configs/*.rb"].each { |file| require file }


before do
  @current_time = Time.now
end

after do
  ActiveRecord::Base.clear_active_connections!
  session.clear
end
