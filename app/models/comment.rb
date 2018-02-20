class Comment < ApplicationRecord
  acts_as_tree order: 'created_at DESC', dependent: :destroy
  belongs_to :wad
  belongs_to :user
end
