atom_feed do |feed|
  feed.title "Kanał RSS - Serialowy Świat"
  feed.updated @videos.first.published_at

  @videos.each do |video|
    feed.entry video do |entry|
      entry.title video.title
      entry.episode video.episode
      entry.season video.season.number
      entry.photo '<img src="' + video.photo.url(:thumbnails) + '" width="100" height="100" alt="Miniaturka" />', :type => 'html' 
      entry.summary '<br /><br />Obejrzyj film lub serial: <a href="' + video_url(video) + '">' + video_url(video) + '</a><br /><br />', :type => 'html'
    end
  end
end
