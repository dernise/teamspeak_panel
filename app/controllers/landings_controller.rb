require 'sqlite3'

class LandingsController < ApplicationController
  before_action :authenticate_user!

  def index
    begin
      db = SQLite3::Database.new "/opt/teamspeak/ts3server.sqlitedb"
      db.results_as_hash = true

      @tokens = db.execute "SELECT * FROM tokens"
    rescue SQLite3::Exception => e

      puts "Exception occurred"
      puts e
    ensure
      db.close if db
    end
  end
end
