# Create JSON storage files if they don't exist
['urls.json', 'visits.json'].each do |filename|
  path = Rails.root.join('db', filename)
  FileUtils.mkdir_p(path.dirname)
  FileUtils.touch(path) unless File.exist?(path)
  File.write(path, '[]') if File.zero?(path)
end 