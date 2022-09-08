class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :circle
  # after_create :initialize_event

  def initialize_event
    Event.create_event(self, 'create')
  end
end
