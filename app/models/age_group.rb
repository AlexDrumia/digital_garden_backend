class AgeGroup < ApplicationRecord
  has_many :event_age_groups
  has_many :events, through: :event_age_groups
end
