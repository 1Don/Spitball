class User < ApplicationRecord
  has_many :flags, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_many :messages
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  acts_as_voter
  has_many :wads, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :collaborations, through: :wads, dependent: :destroy
  attr_accessor :remember_token
  after_create :set_default_profile_image, unless: :photo?
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  serialize :interests, Array
  validates :points, presence: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Sign up from oauth function
  def self.sign_up_from_omniauth(auth)
    if User.find_by(email: auth.info.email)
      find_by(email: auth.info.email)
    else
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.name = auth.info.email.partition('@').first
          user.first_name = auth.info.name.split.first
          user.last_name = auth.info.name.split.last
          user.password = user.password_confirmation = SecureRandom.hex(20)
          user.oauth_token = auth.credentials.token
          unless auth.provider == "linkedin"
            user.photo = open(URI.parse(auth.info.image))
          else
            user.occupation = auth.info.description
            user.location = auth.info.location
          end
           user.save!
        end
    end
  end

  #Controls the search feature
  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end

  #gets rid of friend
  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end

  def set_default_profile_image
    file = Tempfile.new([self.first_name, ".jpg"])
    file.binmode
    file.write(Avatarly.generate_avatar(self.first_name, format: "jpg", size: 300))
    file.read # <-- this fixes the issue
  begin
    self.photo = File.open(file.path)
  ensure
    file.close
    file.unlink
  end
    self.save
  end

  #Sees if user flagged object
  def flagged?(object)
    object.flags.each do |flag|
      return flag.user == self ? true : false
    end
  end

  #Sees if user has a friendship with another user
  def friends_with?(user)
    self.friends.all.each do |f|
      if f == user
        return true
      else
        return false
      end
    end
  end

  #Sees if user has a conversation with another user
  def conversation_with?(user)
    if Conversation.between(self.id, user.id).exists?
      return true
    else
      return false
    end
  end

  private

    def session_with_provider?
      self.provider.present? && self.uid.present?
    end

end
