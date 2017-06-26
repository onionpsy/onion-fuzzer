require 'onion-fuzzer'

class Report

  def initialize(severity, type, method, param, payload, url)
    @date =  Time.now
    @severity = severity
    @method = method.upcase
    @type = type.upcase
    @payload = "#{param}=#{payload}"
    @url = url
  end
  
  def to_s
    " [#{@severity}] (#{@type}) `#{@payload}`, #{@method} #{@url}"
  end
end
