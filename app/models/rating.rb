class Rating < ActiveRecord::Base
  attr_accessible :value
  
  belongs_to :video
  belongs_to :user
end
