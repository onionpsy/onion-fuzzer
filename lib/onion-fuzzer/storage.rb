class Storage
  def read(path)
  end

  def self.entries(dir)
    Dir.entries("storage/#{dir}").reject { |file_name|
      file_name == '.' || file_name == '..'
    }.map { |file_name| 
      File.read("storage/#{dir}/#{file_name}").split("\n")
    }.flatten
  end
end
