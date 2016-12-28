require 'net/http'
require 'json'
require 'date'

module API

  API_VERSION = '/v1'
  ENDPOINT_CHECK = '/versions'
  ENDPOINT_INPUT = '/monsters'
  ENDPOINT_OUTPUT = '/version'

  module_function
  def init(context)
    @uri ||= URI(context.uri)
    @context = context
  end

  def http
    return if @uri.nil?
    @http = Net::HTTP.new(@uri.host, @uri.port)
  end

  def build_query_from(context = @context)
    URI.encode_www_form(major: context.major, minior: context.minior)
  end

  def endpoint(path, context = @context)
    API_VERSION + path + "?" + build_query_from(context)
  end

  def check(context = @context, &block)
    response = http.send_request('GET', endpoint(ENDPOINT_CHECK, context))
    versions = if response.is_a?(Net::HTTPSuccess)
                 JSON.parse(response.body)
               else
                 []
               end
    yield versions if block_given?
  end

  def in(context = @context, &block)
    response = http.send_request('GET', endpoint(ENDPOINT_INPUT, context))
    monsters = if response.is_a?(Net::HTTPSuccess)
                 JSON.parse(response.body)
               else
                 []
               end
    yield monsters if block_given?
  end

  def out(context = @context, &block)
    response = http.send_request('PUT', endpoint(ENDPOINT_OUTPUT, context))
    result = if response.is_a?(Net::HTTPSuccess)
                   JSON.parse(response.body)
                 else
                   {}
                 end
    yield DateTime.parse(result["updated_at"] || Time.now.to_s) if block_given?
  end

end

