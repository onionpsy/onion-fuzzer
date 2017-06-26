require 'onion-fuzzer'

class Analyser

  def check_for_pattern(response, patterns)
    patterns ||= []
    patterns.each do |pattern|
      if response.to_s.include? pattern
        return true
      end
    end
    false
  end
  
  def check_for_payload(response, payload)
    if response.to_s.include? payload
      return true
    end
    false
  end
end
