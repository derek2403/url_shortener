# Create JSON storage directory if it doesn't exist
FileUtils.mkdir_p(Rails.root.join('db'))

# Initialize JSON files if they don't exist
['urls.json', 'visits.json'].each do |filename|
  path = Rails.root.join('db', filename)
  unless File.exist?(path)
    File.write(path, '[]')
  end
end 