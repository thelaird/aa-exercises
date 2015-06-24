require 'uri'
require 'byebug'
module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @req = req
      @params = {}
      @params.merge!(parse_www_encoded_form(req.query_string)) unless req.query_string.nil?
      @params.merge!(parse_www_encoded_form(req.body)) unless req.body.nil?
      @params.merge!(route_params) unless route_params.nil?
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params_array = URI.decode_www_form(www_encoded_form)
      data = params_array.map { |pair| [parse_key(pair.first),pair.last] }
      hash = {}
      data.each do |pair|
        keys = pair.first
        val = pair.last
        current = hash
        keys.each_with_index do |key,idx|
          if idx == keys.length - 1
            current[key] = val
          else
            #byebug
            current[key] ||= {}
            current = current[key]
          end
        end

      end
      return hash
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
