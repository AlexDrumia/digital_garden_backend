class Event < ApplicationRecord
  include PgSearch::Model

  belongs_to :organizer
  has_and_belongs_to_many :categories
  has_many :event_age_groups
  has_many :age_groups, through: :event_age_groups

  validates :name, presence: true
  validates :start_datetime, presence: true
  validates :organizer, presence: true

  pg_search_scope :search_full_text,
                  against: [ :name, :location, :description ],
                  associated_against: {
                    organizer: [ :name ],
                    categories: [ :name ]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  def categories_list
    categories.map(&:name).join(", ")
  end
end
