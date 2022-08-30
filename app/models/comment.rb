class Comment < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :recipe, dependent: :destroy

  validates :content, presence: true, length: { minimum: 6 }
end
