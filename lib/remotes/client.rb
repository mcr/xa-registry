require 'faraday'
require 'faraday_middleware'

module Remotes
  class Client
    def initialize(url)
      @conn = Faraday.new(url) do |f|
        f.request(:url_encoded)
        f.request(:json)
        f.response(:json, :content_type => /\bjson$/)
        f.adapter(Faraday.default_adapter)        
      end
    end

    def get(name, version)
      resp = @conn.get("/rules/#{name}/versions/#{version}")
      resp.success? ? resp.body : nil
    end
  end
end
