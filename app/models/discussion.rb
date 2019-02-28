class Discussion < ApplicationRecord
	 has_one_attached :image
	 acts_as_votable
   belongs_to :user
   has_many :answers, dependent: :destroy
   validates :user_id, presence: true
   has_many :flags, dependent: :destroy
	 validates :title, presence: true, length: { maximum: 500 }
	 def self.search(search)
	    where("content LIKE ?","%#{search}%")
	 end
end
