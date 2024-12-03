namespace :events do
  desc "Refresh image URLs"
  task refresh_image_urls: :environment do
    require "airtable"

    api_key = "pats9KvXvBmivlseG.4a3d9b8d286612bfab38436144cfda8ce68ac9d5603a7a7b43a3c0247802c538"
    base_id = "appE6L6fQPeZ6s8Gt"
    table_name = "Eventi"

    records = fetch_airtable_records(api_key, base_id, table_name)

    events = Event.where.not(image_url: nil)

    events.each do |event|
      record = records.find { |r| r.id == event.airtable_id }
      new_image_url = record.slika&.first&.dig(:thumbnails, :large, :url)
      event.update_attribute!(:image_url, new_image_url)
    end

    puts "Image URLs refreshed!"
  end

  # Helper method to fetch data from Airtable
  def fetch_airtable_records(api_key, base_id, table_name)
    client = Airtable::Client.new(api_key)

    page_size = 100
    offset = 0

    client.table(base_id, table_name).all(params: { offset: offset, limit: page_size })
  end
end
