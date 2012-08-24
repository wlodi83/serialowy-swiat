class User < ActiveRecord::Base                   
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :admin, :avatar
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :oauthable
  # user avatar
  has_attached_file :avatar,
                    :styles => { 
                      :thumb => {
                        :geometry => '60x60#',
                        :quality => 40,
                        :format => 'JPG'
                      },
                      :medium => {
                        :geometry => '100x100#',
                        :quality => 50,
                        :format => 'JPG'
                      }
                    },
                    :default_url => '/images/normal/:style.png'
  has_many :videos, :order => 'published_at DESC, title ASC', :dependent => :nullify
  has_many :replies, :through => :videos, :source => :comments
  has_many :comments
  has_many :ratings
  has_many :rated_videos, :through => :ratings, :source => :videos
  has_and_belongs_to_many :categories
  acts_as_tagger  
  def self.find_for_facebook_oauth(access_token, signed_in_resource = nil)
  	data = ActiveSupport::JSON.decode(access_token.get('https://graph.facebook.com/me?'))
  	if user = User.find_by_email(data["email"])
    		user
  	else # Create an user with a stub password. 
    		User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
  	end
  end
 
  def has_subscription?(subscription_id)
   user = User.find(self)
   category = Category.find(subscription_id)
   return true if user.categories.find_by_id(category)
  end
end
