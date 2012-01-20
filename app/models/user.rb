require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password, :old_password
    attr_accessible :name, :email, :password, :password_confirmation,
    :old_password

  has_many :microposts, :dependent => :destroy
  has_many :relationships,	:foreign_key => "follower_id",
				:dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id", 
				   :class_name => "Relationship",
				   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  email_format = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,      :presence => true,
                        :length => { :maximum => 50 }
  validates :email,     :presence => true,
                        :format => { :with => email_format },
                        :uniqueness => { :case_sensitive => false }
  validates :password,	:presence => true, 
                        :length => { :within => 6..40 },
                        :confirmation => true, 
                        :if => :password_required?

  before_save :encrypt_password

  #compares submitted password to stored password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  #authenticatiom method that sees if a password matches a user found by email
  #this is a class method
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
      return nil if user.nil?
      return user if user.has_password?(submitted_password)
  end

  #authentication method using the user id and salt. For with use with cookies
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(followed)
    self.relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    self.relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    self.relationships.find_by_followed_id(followed).destroy
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def password_required?
    !self.password.nil? || self.new_record?
  end

  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password) if password
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

