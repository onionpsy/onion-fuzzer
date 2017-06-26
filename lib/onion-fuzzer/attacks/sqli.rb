require 'onion-fuzzer'

class SQLI < Attack
  def initialize
    super('sqli')
    @patterns = Storage.entries("patterns/errors/")
  end
  
  def query(method, url, payload, param, cookies, params)
    response = super(method, url, payload, param, cookies, params)

    if @analyser.check_for_pattern(response, @patterns)
      puts Report.new(:critical, 'SQLI', method, param, payload, url)
    end
  end
end
