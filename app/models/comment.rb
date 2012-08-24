class Comment < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates :name, :email, :body, :presence => true
  validate :video_should_be_published
  
  def video_should_be_published
    errors.add(:video_id, "is not published yet") if video && !video.published?
  end
end
