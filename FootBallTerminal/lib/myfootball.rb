class MyFootball
  def initialize(matches = {})
    @matches = matches
  end

  def true?
    true
  end

  def get_new_API
    ya = YAML.load(ERB.new(File.read('./lib/config.yml')).result)
    key = ya["api"]["api_key"]
    base_url = ya["api"]["base_url"]
    end_point = ya["api"]["end_point"]["competitions"]["matches"]
    response = Http.headers("accept" => "application/json", "X-Auth-Token" => key).
    get(base_url + end_point)
    JSON.parse response.body.to_s
  end

  def store_data
    @matches = get_new_API
  end

  def show_info
    rows = []
    store_data["matches"].each_with_index do |match, i|
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
