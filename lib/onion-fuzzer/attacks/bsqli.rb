require 'onion-fuzzer'

class BSQLI < Attack
  def initialize
    super('bsqli')
  end
  
  def query(method, url, payload, param, cookies, params)
    before = Time.now
    super(method, url, payload, param, cookies, params)
    if Time.now - before > 2
      puts Report::new(:high, 'BSQLI', method, param, payload, url)
    end
  end
end
