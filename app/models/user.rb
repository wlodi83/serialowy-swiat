class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :admin, :avatar, :provider, :uid

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
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         avatar:auth.info.image,
                         password:Devise.friendly_token[0,20]
                         )
    end
      user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def has_subscription?(subscription_id)
   user = User.find(self)
   category = Category.find(subscription_id)
   return true if user.categories.find_by_id(category)
  end
end
