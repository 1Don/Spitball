class Friendship < ApplicationRecord
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship
<<<<<<< HEAD
  validate :not_self
=======
>>>>>>> development

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def create_inverse_relationship
    friend.friendships.create(friend: user)
  end

<<<<<<< HEAD
  def not_self
  errors.add(:friend, "It's good to be your own friend but nah") if user == friend
  end

=======
>>>>>>> development
  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end
<<<<<<< HEAD
=======

  def not_self
   errors.add(:friend, "can't be equal to user") if user == friend
  end

>>>>>>> development
end
