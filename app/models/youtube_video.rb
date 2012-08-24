class YoutubeVideo < ActiveRecord::Base
  attr_accessible :title, :description, :yt_video_embed, :mainpage, :published, :category_ids
  has_and_belongs_to_many :categories
  #thinking_sphinx
  define_index do
    indexes title
    indexes description
  end

  def to_param
    "#{id}-#{title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end
end
