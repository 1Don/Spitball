class Wad < ApplicationRecord
  has_attached_file :image, styles: { large: "500x500>", medium: "250x250>", thumb: "50x50#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :category, presence: true
  validates :long_form, presence: true, length: { maximum: 5000 }
  validates :problem_state, presence: true, length: { maximum: 75 }
  has_many :users, through: :comments
  has_many :collaborations
  has_many :users, through: :collaborations
#Search Functionality
 def self.search(search)
    where("problem_state LIKE ? OR long_form LIKE ? OR tags LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
 end
end
