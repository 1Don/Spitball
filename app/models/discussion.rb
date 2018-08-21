class Discussion < ApplicationRecord
	 has_attached_file :image, styles: { large: "500x500>", medium: "250x250>", thumb: "50x50#"}
	 acts_as_votable
     belongs_to :user
     has_many :answers, dependent: :destroy
     validates :user_id, presence: true
     has_many :flags
 def self.search(search)
    where("content LIKE ?","%#{search}%") 
 end
end
