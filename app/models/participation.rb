class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :circle

  after_commit :initialize_event, on: :create


  def initialize_event
    Event.create_event(self, 'create')
  end
end
