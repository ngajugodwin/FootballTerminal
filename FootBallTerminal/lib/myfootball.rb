require 'rubygems'
require 'pry'
require 'rainbow'
require 'terminal-table'
#require './lib/config'
require 'yaml'
require 'http'

class MyFootball

  def initialize(matches = {})
    @matches = matches
  end

  def getNewAPI
    ya = YAML.load_file('yaml.yml')
    key = ya["api"]["api_key"]
    base_url = ya["api"]["base_url"]
    end_point = ya["api"]["end_point"]["competitions"]["matches"]
    response = Http.headers("accept" => "application/json", "X-Auth-Token" => key).
    get(base_url + end_point)
    JSON.parse response.body.to_s
  end

  def storeData
    @matches = getNewAPI
  end

  def showInfo
    rows = []
    storeData["matches"].each_with_index do |match, i|
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
puts f.showInfo
