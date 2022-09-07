class Event < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates :description, presence: true

  def self.create_event(element, action)
    if element.class.to_s == "CircleRecipe" && action == 'create'
      Event.create!(description: "#{element.recipe.name} has been added to #{element.circle.name}")
    elsif element.class.to_s == "Participation" && action == 'create'
      Event.create!(description: "#{element.user.first_name} has been added to #{element.circle.name}")
    elsif element.class.to_s == "Recipe" && action == 'create'
      Event.create!(description: "#{element.name} has been created")
    elsif element.class.to_s == "User" && action == 'delete'
      Event.create!(description: "#{element.user.first_name} has been deleted to #{element.circle.name}")
    elsif element.class.to_s == "Comment" && action == 'create'
      Event.create!(description: "#{element.comment} has been added to #{element.recipe.name}")
    end
  end
end
