class Participation < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :circle
end
