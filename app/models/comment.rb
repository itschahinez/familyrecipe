class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :content, presence: true, length: { minimum: 6 }

  after_commit :initialize_event, on: :create
  def initialize_event
    Event.create_event(self, 'create')
  end
end
