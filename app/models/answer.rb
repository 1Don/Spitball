class Answer < ApplicationRecord
  acts_as_votable
  acts_as_tree order: 'created_at DESC', dependent: :destroy
  belongs_to :discussion
  belongs_to :user
  has_many :flags, dependent: :destroy
  validates :content, presence: true, length: { maximum: 1000 }
end
