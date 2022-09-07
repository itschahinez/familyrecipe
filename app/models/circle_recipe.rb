class CircleRecipe < ApplicationRecord
  belongs_to :circle
  belongs_to :recipe
  has_many :users

  #after_create :initialize_event
  def initialize_event
    Event.create_event(self, 'create')
  end
end
