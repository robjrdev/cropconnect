class Rating < ApplicationRecord
  belongs_to :rice

  validates :age, :whiteness, :dryness, :pureness, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :rice_id, presence: true
end
