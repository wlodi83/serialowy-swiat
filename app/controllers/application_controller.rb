class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_categories, :load_videos, :load_titles, :video_first, :five_top_videos, :five_new_comments
  def five_new_comments
    @five_new_comments = Comment.limit(5).order("created_at DESC")
  end

  def five_top_videos
    @videos = Video.all
    video_hash = Hash.new("Top Ten Videos")
    @videos.each do |video|
      video_hash[video.id] = Video.current_counter_hits(video.id).to_i
    end
    sorted_array = video_hash.sort_by { |k,v| v }.reverse
    @five_top_videos = []
    sorted_array[0..4].each do |k|
      @five_top_videos << Video.select(:id).find(k[0]).id
    end
    @five_videos_table = []
    j = 0
    @five_top_videos.each do |id|
      @five_videos_table[j] = Video.find(id)
      j += 1
    end
  end

  def video_first
    @video_first = Video.first(:order => "RANDOM()")
  end

  def initialize
    super
    @tags = Video.tag_counts_on(:tags, :limit => 20, :order => "count desc")
  end
  
  def load_videos
    @carousel_videos = Video.limit(35).order("RANDOM()")
  end
  
  def load_categories
    @categories = Category.roots
  end
  
  def load_titles
    @videos_titles = Video.where("season_id = ? and episode = ? or season_id is ? and episode is ?", 1, 1, nil, nil).select("distinct(title), id").order("title ASC")
  end
  
  private
  
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
