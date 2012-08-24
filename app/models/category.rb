class Category < ActiveRecord::Base
  has_and_belongs_to_many :videos
  has_and_belongs_to_many :youtube_videos
  has_and_belongs_to_many :users
  acts_as_tree :order => "name"
  default_scope order('categories.name')
end
