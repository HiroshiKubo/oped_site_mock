module ArticlesHelper
  #A8のパース
  def a8_parse(a8_text)
    charset = "utf-8"
    html = Nokogiri::HTML.parse(a8_text, nil, charset)
    hash = Hash.new
    hash[:img] = html.css('img')[0].attributes["src"].value
    hash[:url] = html.css('a')[0].attributes["href"].value
    hash
  end
end
