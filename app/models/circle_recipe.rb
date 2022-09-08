class CircleRecipe < ApplicationRecord
  belongs_to :circle
  belongs_to :recipe
  has_many :users


  after_commit :initialize_event, on: :create

  def initialize_event
    Event.create_event(self, 'create')
  end
end
