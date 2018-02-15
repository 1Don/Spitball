class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wad
  validates :content, presence: true
end
