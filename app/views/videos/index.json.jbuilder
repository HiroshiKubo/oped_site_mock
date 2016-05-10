json.array!(@videos) do |video|
  json.extract! video, :id, :anime_id, :video_url, :frame, :release
  json.url video_url(video, format: :json)
end
