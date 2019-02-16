class Bucket < ApplicationRecord
  has_many :tasks
  belongs_to :collaboration
  validates :title, presence: true
end
