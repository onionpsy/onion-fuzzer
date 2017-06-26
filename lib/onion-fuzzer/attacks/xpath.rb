require 'onion-fuzzer'

class XPATH < Attack
  def initialize
    super('xpath')
    @patterns = Storage.entries("patterns/errors")
  end
  
  def query(method, url, payload, param, cookies, params)
    response = super(method, url, payload, param, cookies, params)
    if @analyser.check_for_pattern(response, @patterns)
      puts Report::new(:high, 'Xpath', method, param, payload, url)
    end
  end
end
