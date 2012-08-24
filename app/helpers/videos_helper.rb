module VideosHelper
include ActsAsTaggableOn::TagsHelper
def rating_ballot
  if @rating = current_user.ratings.find_by_video_id(params[:video_id])
     @rating
  else
     current_user.ratings.new
  end
end

def current_user_rating
  if params[:id] and @rating = current_user.ratings.find_by_video_id(params[:id])
     @rating.value
  elsif params[:video_id] and @rating = current_user.ratings.find_by_video_id(params[:video_id])
     @rating.value
  else
    "You have not voted yet. Please vote for your favourite video."
  end
end

def next_videos(video)
  @video = video
  if @video.season.nil? and @video.episode.nil?
    html = ''
    return html.html_safe
  else
    @next_videos = Video.where("title like ? and episode != ? and season_id = ? and episode > ?", "#{@video.title.sub(/(\s\((ENG|eng|Eng)\)\sS\d+E\d+|\s\((PL|Pl|pl)\)\sS\d+E\d+|\sS\d+E\d+)/, '')}%" ,"#{@video.episode}", "#{@video.season.number}", "#{@video.episode}").order('episode ASC')
    if @next_videos.length > 0
      html = "<h3>#{@video.title}: nastepne odcinki sezonu #{@video.season.number}</h3>"
      @next_videos.each do |video|
        html << "<div class=\"similar\">"
        html << "<a href=\"#{video.to_param}\"><img src=\"#{video.photo.url(:thumbnails)}\" alt=\"Video Picture\" /></a>" 
        html << "<p>Odcinek: #{video.episode}<p>"
        html << '</div>'
      end
      return html.html_safe
    else
      html = ''
      html = "<h3>#{@video.title}: nastepne odcinki sezonu #{@video.season.number}</h3>"
      html << '<p>Przepraszamy ale nie ma nastepnych odcinkow</p>'
    
      return html.html_safe
    end
  end
end

def previous_videos(video)
  @video = video
  if @video.season.nil? and @video.episode.nil?
    html = ''
    return html.html_safe
  else
    @previous_videos = Video.where("title like ? and episode != ? and season_id = ? and episode < ?", "#{@video.title.sub(/(\s\((ENG|eng|Eng)\)\sS\d+E\d+|\s\((PL|Pl|pl)\)\sS\d+E\d+|\sS\d+E\d+)/, '')}%", "#{@video.episode}", "#{@video.season.number}", "#{@video.episode}").order('episode DESC')
    if @previous_videos.length > 0
      html = "<h3>#{@video.title}: poprzednie odcinki sezonu #{@video.season.number}</h3>"
      @previous_videos.each do |video|
        html << "<div class=\"similar\">"
        html << "<a href=\"#{video.to_param}\"><img src=\"#{video.photo.url(:thumbnails)}\" alt=\"Video Picture\" /></a>"
        html << "<p>Odcinek: #{video.episode}</p>"
        html << '</div>'
      end
      return html.html_safe
    else
      html = ''
      html = "<h3>#{@video.title}: poprzednie odcinki sezonu #{@video.season.number}</h3>"
      html << '<p>Przepraszamy ale nie ma poprzednich odcinkow</p>'

      return html.html_safe
    end
  end
end

def video_seasons(video)
  @video = video
  if @video.season.nil? and video.episode.nil?
    html = ''
    return html.html_safe
  else
    @video_seasons = Video.where("title like ? and season_id != ?", "#{@video.title.sub(/(\s\((ENG|eng|Eng)\)\sS\d+E\d+|\s\((PL|Pl|pl)\)\sS\d+E\d+|\sS\d+E\d+)/, '')}%", "#{@video.season.number}").select("distinct season_id")
    if @video_seasons.length > 0
      html = '' 
      @video_seasons.each do |season|
        html << "<a href=\"#{video_season_path(:video_id => @video.id, :id => season.season_id)}\">Sezon #{season.season.number}</a> | "    
      end
      return html.html_safe
    else
      html = ''
      html << "<a href=\"#{video_season_path(:video_id => @video.id, :id => @video.season.number)}\">Sezon #{@video.season.number}</a>"
      return html.html_safe
    end
  end
end

end
