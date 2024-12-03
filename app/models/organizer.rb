class Organizer < ApplicationRecord
  has_many :events

  validates :name, :email, presence: true
end
