class Wad < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
#  has_attached_file :photo, styles: { medium "300x300>", thumb: "100x100>"}
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :category, presence: true
  validates :long_form, presence: true, length: { maximum: 1000 }
  validates :short_form, presence: true, length: { maximum: 140 }
  validates :problem_statement, presence: true, length: { maximum: 50 }
end
