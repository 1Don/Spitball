class Wad < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :category, presence: true
  validates :long_form, presence: true, length: { maximum: 1000 }
  validates :short_form, presence: true, length: { maximum: 140 }
  validates :problem_state, presence: true, length: { maximum: 50 }
end
