class Visit
  include ActiveModel::Model
  attr_accessor :id, :short_url_id, :ip_address, :location, :created_at

  class << self
    def json_file
      Rails.root.join('db', 'visits.json')
    end

    def all
      return [] unless File.exist?(json_file)
      
      JSON.parse(File.read(json_file)).map do |attrs|
        new(attrs)
      end
    end

    def create(attributes)
      visits = all
      new_visit = new(
        id: SecureRandom.uuid,
        short_url_id: attributes[:short_url_id],
        ip_address: attributes[:ip_address],
        location: Geocoder.search(attributes[:ip_address]).first&.country || 'Unknown',
        created_at: Time.current
      )
      
      visits << new_visit
      save_to_json(visits)
      new_visit
    end

    private

    def save_to_json(visits)
      File.write(
        json_file,
        JSON.pretty_generate(
          visits.map(&:to_h)
        )
      )
    end
  end

  def to_h
    {
      id: id,
      short_url_id: short_url_id,
      ip_address: ip_address,
      location: location,
      created_at: created_at
    }
  end
end 