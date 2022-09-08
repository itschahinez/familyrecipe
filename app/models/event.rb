class Event < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates :description, presence: true

  def self.create_event(element, action)
    Current.user = User.first if Current.user.nil?
    if element.class.to_s == "CircleRecipe" && action == 'create'
      Event.create!(description: "#{element.recipe.name} has been added to #{element.circle.name} by #{Current.user.first_name}")
    elsif element.class.to_s == "Participation" && action == 'create'
      Event.create!(description: "#{element.user.first_name} has been added to #{element.circle.name} by #{Current.user.first_name}")
    elsif element.class.to_s == "Recipe" && action == 'create'
      Event.create!(description: "#{element.name} has been created by #{Current.user.first_name}")
    elsif element.class.to_s == "Comment" && action == 'create'
      Current.user = element.user
      Event.create!(description: "A new comment has been added to #{element.recipe.name} by #{Current.user.first_name}")
    end
  end
end
