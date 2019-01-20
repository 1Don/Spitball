class User < ApplicationRecord
  has_and_belongs_to_many :collaborations
  has_many :collaborations
  has_many :collaboration_requests
  has_many :flags, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_many :messages
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_one_attached :photo
  acts_as_voter
  has_many :wads, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :collaborations, through: :wads, dependent: :destroy
  attr_accessor :remember_token, :reset_token
  after_create :set_default_profile_image, unless: :has_attachment?
  before_save { self.email = email.downcase }
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
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

  def has_attachment?
    if self.photo.attached?
      return true
    else
      return false
    end
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
            user.photo.attach(io: open(auth.info.image), filename: user.name, content_type: open(auth.info.image).content_type)
          else
            user.giveAvatar
            user.photo.attach(io: File.open(Rails.root.join('storage', 'temp_images', user.name + ".jpg")), filename: user.name, content_type: "image/jpg")
          end
          user.occupation = auth.info.description
          user.location = auth.info.location
          user.save!
        end
    end
  end


# Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

# Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  #Controls the search feature
  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end

  def giveAvatar(image = false)
    img = Avatarly.generate_avatar(self.name, size: 300, format: "jpg")
    if image
      File.open(Rails.root.join('storage', 'temp_images', self.name + ".jpg"), "w+") do |f|
        f.binmode
        f.write image
      end
    else
      File.open(Rails.root.join('storage', 'temp_images', self.name + ".jpg"), "w+") do |f|
        f.binmode
        f.write img
      end
    end
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

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  #Sees if user has a conversation with another user
  def conversation_with?(user)
    if Conversation.between(self.id, user.id).exists?
      return true
    else
      return false
    end
  end


  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    def session_with_provider?
      self.provider.present? && self.uid.present?
    end

end
