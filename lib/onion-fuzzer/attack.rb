require 'onion-fuzzer'
require 'http'

class Attack

  @payloads = []
  
  # @param dir
  def initialize(dir)
    # Read payloads from storage
    @type = dir.downcase
    @payloads = Storage.entries("payloads/#{@type}")
    @analyser = Analyser.new
    @http = HTTP.follow
  end
  
  def query(method, url, payload, param, cookies, params)
    cookies ||= {}
    case method.downcase
    when 'get'
      @http.cookies(cookies).get(url, params: params.merge({param => payload}))
    when 'post'
      @http.cookies(cookies).post(url, form: params.merge({param => payload}))
    end
  end
  
  # @param params [Hash]
  def raw_params(params)
    params.map { |p| p.to_a * '=' } * '&'
  end
  
  # @param params [Hash]
  def encoded_params(params)
    URI.encode_www_form(params)
  end
  
  # @param url
  # @parm method
  # @param options [Hash]
  def run(url, method, options)
    @payloads.each do |payload|
      options['params']
        .select { |p, v| v.nil? }
        .each do |param, n|
          self.query(
            method,
            url,
            payload,
            param,
            options['cookies'],
            options['params'].reject { |p, v| v.nil? } # keep params with values
          )
      end
    end
  end
end
