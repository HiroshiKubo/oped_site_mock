json.array!(@anime_data) do |anime_datum|
  json.extract! anime_datum, :id, :japanese, :english, :chinese, :year, :month, :url
  json.url anime_datum_url(anime_datum, format: :json)
end
