require 'thor'

module Onionfuzzer
  class CLI < Thor
    package_name "App"                                             # [2]
    map "-L" => :list                                              # [3]
    method_options :force => :boolean, :alias => :string           # [5]
    
    desc '', ''
    def fuzz(file='')
      unless File.exist? file
        puts 'no files'
      end
      
      endpoints = YAML.load_file(file)
      endpoints.each do |url, attacks|
        attacks.each do |name, elements|
          elements.each do |method, options|
            options['types'].each do |type|
              attack = Object.const_get(type.upcase).new
              attack.run(url, method, options)
            end
          end
        end
      end
    end
  end
end
