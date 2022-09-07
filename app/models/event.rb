class Event < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates :description, presence: true

  def self.create_event(element, action)
    case element.class
    when CircleRecipe && action == 'create'
      Event.create!(description: "#{element.recipe.name} has been added to #{element.circle.name}")
    when Participation && action == 'create'
      Event.create!(description: "#{element.user.first_name} has been added to #{element.circle.name}")
    when Recipe && action == 'update'
      Event.create!(description: "#{element.name} has been updated")
    when User && action == 'delete'
      Event.create!(description: "#{element.user.first_name} has been deleted to #{element.circle.name}")
    when Comment && action == 'create'
      Event.create!(description: "#{element.comment} has been added to #{element.recipe.name}")
    end
  end
end
