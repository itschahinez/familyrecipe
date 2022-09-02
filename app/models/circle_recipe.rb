class CircleRecipe < ApplicationRecord
  belongs_to :circle
  belongs_to :recipe


  def self.create_path
    raise
  end
end
