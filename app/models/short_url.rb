class ShortUrl
  include ActiveModel::Model
  attr_accessor :id, :target_url, :short_path, :title, :created_at

  class << self
    def json_file
      Rails.root.join('db', 'urls.json')
    end

    def all
      return [] unless File.exist?(json_file)
      
      JSON.parse(File.read(json_file)).map do |attrs|
        new(attrs)
      end
    end

    def find_by_short_path(path)
      all.find { |url| url.short_path == path }
    end

    def create(attributes)
      urls = all
      new_url = new(
        id: SecureRandom.uuid,
        target_url: attributes[:target_url],
        short_path: generate_unique_path,
        title: fetch_title(attributes[:target_url]),
        created_at: Time.current
      )
      
      urls << new_url
      save_to_json(urls)
      new_url
    end

    private

    def generate_unique_path
      loop do
        path = SecureRandom.alphanumeric(8)
        return path unless find_by_short_path(path)
      end
    end

    def fetch_title(url)
      response = URI.open(url)
      doc = Nokogiri::HTML(response)
      doc.title || url
    rescue
      url
    end

    def save_to_json(urls)
      File.write(
        json_file,
        JSON.pretty_generate(
          urls.map(&:to_h)
        )
      )
    end
  end

  def to_h
    {
      id: id,
      target_url: target_url,
      short_path: short_path,
      title: title,
      created_at: created_at
    }
  end
end 