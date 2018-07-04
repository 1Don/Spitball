class FriendRequest < ApplicationRecord
<<<<<<< HEAD
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self

   def accept
=======
  validate :not_friends
  validate :not_pending
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  belongs_to :user
  belongs_to :friend, class_name: 'User'

#creates friend relationship and destroys friend request
  def accept
>>>>>>> development
    user.friends << friend
    destroy
  end

<<<<<<< HEAD
private

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
=======

private  
  def not_self
   errors.add(:friend, "can't be equal to user") if user == friend
  end

  def not_friends
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'already requested friendship') if friend.pending_friends.include?(user)
>>>>>>> development
  end

end