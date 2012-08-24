class Video < ActiveRecord::Base
  attr_accessible :title, :link, :photo, :category_ids, :season_id, :episode, :published_at, :published, :tag_list, :mainpage
  self.per_page = 5
  before_save :update_published_at
  acts_as_taggable_on :tags
  belongs_to :user
  belongs_to :season
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :users
  has_and_belongs_to_many :categories
  has_many :comments, :dependent => :destroy

  has_attached_file :photo, :styles => { :medium => "300x300\#", :mini => "200x200\#", :thumbnails => "100x100\#" }
  #Validations
  validates_attachment_presence :photo                    
  validates_attachment_size :photo, :less_than => 5.megabyte
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates :title, :presence => true
  validates :link, :presence => true,
		   :uniqueness => true,
                   :format => { :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }
  #Scopes
  scope :five_new, where(:published => true).limit(5).order("published_at DESC")

  #thinking_sphinx
  define_index do
    indexes title 
  end 
  # redis
  def self.set_hits_counter(video_id)
   begin
   $redis.ping
   rescue Errno::ECONNREFUSED
   else
   $redis.set "video_counter_hits_#{video_id}", 0
   end 
  end
  def self.increase_hits_counter(video_id)
   begin
   $redis.ping
   rescue Errno::ECONNREFUSED
   else
   $redis.incr "video_counter_hits_#{video_id}"
   end
  end
  def self.current_counter_hits(video_id)
   begin
   $redis.ping
   rescue Errno::ECONNREFUSED
   else
   $redis["video_counter_hits_#{video_id}"]
   end
  end
  def average_rating
    @value = 0
    self.ratings.each do |rating|
      @value = @value + rating.value
    end
    @total = self.ratings.size
    @value.to_f / @total.to_f 
  end
 
  def update_published_at
    self.published_at = Time.now if published == true  
  end

  def published?
    published_at.present?
  end

  def to_param
    "#{id}-#{title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end
end
