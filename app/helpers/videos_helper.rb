module VideosHelper
  #Youtubeの動画をキーワードで検索
  def searchYoutubeVideos(search_keyword, max_results)
    search_keyword = search_keyword.to_s
    max_results    = max_results.to_s
    @youtube_api_key        = "AIzaSyAxwRuvgjWnA54G9HL6jO5Pr373vJzyHI8"
    serach_videos_list_url      = "https://www.googleapis.com/youtube/v3/search?part=snippet&"

    url = serach_videos_list_url+"&q="+search_keyword+"&key="+@youtube_api_key+"&maxResults="+max_results
    url = URI.escape(url)
    res = open(url)
    code, message = res.status

    if code == '200'
      result = res.read

      videos_data = JSON.parse(result)["items"]

      videos_time = getYoutubeVideosTime(videos_data)

      videos = registYoutubeVideos(videos_data, videos_time)
      videos
    else
      puts "#{code} #{message}"
    end
  end

  #取得した動画の時間一覧を取得
  def getYoutubeVideosTime(youtube_data)
    search_videos_time_url = "https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id="
    videos_id = ""
    youtube_data.map { |data|
      videos_id += data["id"]["videoId"].to_s + ","
    }

    video_url = search_videos_time_url+videos_id.chop+"&key="+@youtube_api_key

    res = open(video_url)
    code, message = res.status

    if code == '200'
      result = res.read
      puts result
      videos_data = JSON.parse(result)

      videos_time = videos_data["items"].map { |data|
        data["contentDetails"]["duration"]
        cut = data["contentDetails"]["duration"].split(/PT|M|S/)
        timeToSecChange(cut[0],cut[1],cut[2])
      }

      videos_time
    else
      puts "#{code} #{message}"
    end
  end

  def registYoutubeVideos(videos_data, videos_time)
    frame_url_before = '<iframe width="640" height="360" src="'
    frame_url_after  = '" frameborder="0" allowfullscreen></iframe>'

    videos = videos_data.map.with_index{ |data,num|
      if videos_time[num].to_i > 30 && videos_time[num].to_i < 150
        video = Video.new

        video[:video_url] = data["id"]["videoId"]
        video[:image]     = data["snippet"]["thumbnails"]["default"]["url"]
        video[:title]     = data["snippet"]["title"]
        video[:frame]     = "youtube"
        video[:release]   = false
        video
      end
    }
    videos.compact
  end

  def timeToSecChange(pt,min,sec)
    pt  = 0 if pt.empty?
    min = 0 if min.empty?

    pt  = pt.to_i
    min = min.to_i
    sec = sec.to_i

    pt*60*60+min*60+sec
  end

  def videoIdToLink(search_site, video_id)
    video_url = "https://www.youtube.com/embed/"+video_id if search_site == "youtube"
    video_url = "http://player.youku.com/embed/"+video_id if search_site == "youku"
    video_url
  end

  #Youkuのvideoを探す
  def searchYoukuVideos(keyword, max_page)
    charset     = nil
    user_agent  = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)"
    search_urls = makeSearchYoukuUrl(keyword,max_page)
    videos = []
    search_urls.map { |search_url|
      html = open(search_url, "User-Agent" => user_agent) do |f|
        charset = f.charset
        f.read
      end

      doc = Nokogiri::HTML.parse(html, nil, charset)
      videos.concat(makeYoukuData(doc))
    }

    videos
  end

  #youkuのURL一覧を作成
  def makeSearchYoukuUrl(keyword, max_page)
    if max_page == 1 || max_page == nil
      youku_url = "http://www.soku.com/search_video/q_"
      search_url = youku_url+keyword
      search_url = URI.escape(search_url)
    else
      search_urls = max_page.times.map{ |num|
        num = num+1
        youku_url = "http://www.soku.com/search_video/q_"
        search_url = youku_url+keyword+"?page="+num.to_s
        search_url = URI.escape(search_url)
      }
      search_urls
    end
  end

  #動画のidと時間のデータを作成
  def makeYoukuData(doc)
    times_data = doc.css('.v-time').map { |data|
      #puts data.text
      time_text     = data.text
      cut_time_text = time_text.split(":")
      timeToSecChange("", cut_time_text[0], cut_time_text[1])
    }

    images = doc.css('.v-thumb > img').map { |data|
      data["src"]
    }

    youku_videos = doc.css('.v-link > a').map.with_index { |data,i|
      if times_data[i] > 40 && times_data[i] < 150
        video = Video.new
        video[:video_url] = data["_log_vid"]
        video[:title]     = data["title"]
        video[:image]     = images[i]
        video[:frame]     = "youku"
        video[:release]   = false
        video
      end
    }
    youku_videos.compact
  end

  #youtubeのfarame表示
  def MovieFrame(video_id, search_site)
    frame_url = "https://www.youtube.com/embed/" if search_site == "youtube"
    frame_url = "http://player.youku.com/embed/" if search_site == "youku"

    iframe = content_tag(
      :iframe,
      '', # empty body
      width: 640,
      height: 360,
      src: frame_url+"#{video_id}",
      frameborder: 0,
      allowfullscreen: true
    )
    content_tag(:div, iframe, class: 'youtube-container')
  end
end
