module AnimeDataHelper
  require 'open-uri'
  require 'json'
  
  def callAnimeData(year, month)
    #monthは1が冬アニメ、2が春アニメのようにする
    res = open('http://api.moemoe.tokyo/anime/v1/master/'+year.to_s+'/'+month.to_s)
  
    code, message = res.status
  
    if code == '200'
      result = res.read
      anime_data = JSON.parse(result)
      anime_data
    else
      puts "OMG!! #{code} #{message}"
    end
  end
  
  def getAnimeData(year, month)
    anime_data = callAnimeData(year,month)
    
    animes_data = anime_data.map{ |data|
      anime_data = AnimeDatum.new
      anime_data[:japanese] = data["title"]
      anime_data[:year]     = year
      anime_data[:month]    = month
      anime_data[:url]      = data["public_url"]
      anime_data
    }
    return animes_data
  end
  
end
