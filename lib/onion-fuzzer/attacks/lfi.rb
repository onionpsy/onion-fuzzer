require 'onion-fuzzer'

class LFI < Attack
  def initialize
    super('lfi')
    @patterns = Storage.entries("patterns/lfi")
  end
  
  def query(method, url, payload, param, cookies, params)
    response = super(method, url, payload, param, cookies, params)

    if @analyser.check_for_pattern(response, @patterns)
      puts Report.new(:critical, 'SQLI', method, param, payload, url)
    end
  end

end
