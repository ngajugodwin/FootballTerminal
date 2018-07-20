require 'rubygems'
require 'http'
require 'pry'
require 'rainbow'
require 'terminal-table'

class MyFootball

def initialize(matches = {})
  @matches = matches
end

def getAPI
    response = Http.headers("accept" => "application/json", "X-Auth-Token" => "512b99e3264840528bd4e04c0153545c").
      get("http://api.football-data.org/v2/competitions/2014/matches?matchday=8")
    JSON.parse response.body.to_s
end

def store
  @matches = getAPI
end

def show
  store
  #puts @matches
end


def table
  rows = []
  store["matches"].each_with_index do |match, i|
    home = match["awayTeam"]["name"]
    away = match["homeTeam"]["name"]
    scoreHome = match["score"]["fullTime"]["homeTeam"]
    scoreAway = match["score"]["fullTime"]["awayTeam"]
    i+=1
    rows << ["#{i}", "#{home}", "#{scoreHome} - #{scoreAway}", "#{away}"]
  end
  table = Terminal::Table.new :headings => ['S/N', 'Home Team', 'Score', 'Away Team'], :rows => rows, :title => "Live Scores"
  puts table
return
end

end


f= MyFootball.new
puts f.table
