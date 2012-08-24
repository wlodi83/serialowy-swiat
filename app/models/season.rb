class Season < ActiveRecord::Base
  has_many :videos, :dependent => :nullify
end
