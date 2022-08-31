class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :content, presence: true, length: { minimum: 6 }
end
