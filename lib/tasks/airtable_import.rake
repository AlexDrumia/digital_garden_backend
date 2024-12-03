namespace :airtable do
  desc "Import data from Airtable"
  task import: :environment do
    require "airtable"

    api_key = ENV["AIRTABLE_API_KEY"]
    base_id = ENV["AIRTABLE_BASE_ID"]


    # Fetch tables
    organizers = fetch_airtable_records(api_key, base_id, "Organizatori")
    categories = fetch_airtable_records(api_key, base_id, "Kategorije")
    events = fetch_airtable_records(api_key, base_id, "Eventi")

    # Import organizers
    organizers.each do |rec|
      Organizer.find_or_create_by(airtable_id: rec.id) do |org|
        org.name = rec.ime
        org.email = rec.kontakt_mail
        org.save!
      end
    end

    # Import categories
    categories.each do |rec|
      Category.find_or_create_by(airtable_id: rec.id) do |cat|
        cat.name = rec.ime
        cat.save!
      end
    end

    # Import events
    events.each do |rec|
      Event.find_or_create_by(airtable_id: rec.id) do |event|
        event.name = rec.skraćeni_naziv
        event.location = rec.lokacija
        event.description = rec.opis
        event.start_datetime = rec.datum_i_vrijeme_početka
        event.end_datetime = rec.datum_i_vrijeme_kraja
        event.price = rec.cijena
        event.event_url = rec.poveznica_na_događaj
        event.kid_friendly = rec.primjereno_za_djecu
        event.image_url = rec.slika&.first&.dig(:thumbnails, :large, :url)

        # Associate with organizer
        if rec.organizator
          organizer = Organizer.find_by(airtable_id: rec.organizator[0])
          event.organizer = organizer
        end

        # Associate with category
        if rec.kategorija
          category = Category.find_by(airtable_id: rec.kategorija[0])
          event.categories << category
        end

        event.save!
      end
    end

    puts "Data import completed!"
  end

  # Helper method to fetch data from Airtable
  def fetch_airtable_records(api_key, base_id, table_name)
    client = Airtable::Client.new(api_key) # , base_id: base_id)

    page_size = 100
    offset = 0

    client.table(base_id, table_name).all(params: { offset: offset, limit: page_size })
  end
end
