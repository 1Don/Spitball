class Discussion < ApplicationRecord
	 acts_as_votable
     belongs_to :user
     acts_as_tree

 def self.search(search)
    where("content LIKE ?","%#{search}%") 
 end
end
