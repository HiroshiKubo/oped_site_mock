json.array!(@articles) do |article|
  json.extract! article, :id, :anime_id, :title, :video_id, :content, :oped, :number, :advertisement, :initials
  json.url article_url(article, format: :json)
end
