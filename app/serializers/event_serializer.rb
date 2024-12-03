class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :category,
             :location,
             :description,
             :start_datetime,
             :end_datetime,
             :price,
             :kid_friendly,
             :event_url,
             :created_at,
             :updated_at,
             :airtable_id,
             :image_url

  def category
    object.categories_list
  end
end
