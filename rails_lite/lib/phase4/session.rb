require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @req = req
      @cookie_hash = {}
      find_cookie
    end

    def find_cookie
      @req.cookies.each do |cookie|
        @cookie_hash = JSON.parse(cookie.value) if cookie.name == "_rails_lite_app"
      end
    end

    def [](key)
      @cookie_hash[key]
    end

    def []=(key, val)
      @cookie_hash[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app',@cookie_hash.to_json)
    end
  end
end
