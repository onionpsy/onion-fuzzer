require 'onion-fuzzer'

class XSS < Attack
  def initialize
    super('xss')
  end
  
  def query(method, url, payload, param, cookies, params)
    response = super(method, url, payload, param, cookies, params)
    if @analyser.check_for_payload(response, payload)
      puts Report::new(:high, 'XSS', method, param, payload, url)
    end
  end
end
