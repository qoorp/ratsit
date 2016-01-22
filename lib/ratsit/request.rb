
require 'faraday'
require 'uri'
require 'json'
require 'ratsit/errors'
require 'ratsit/filters'
require 'ratsit/search_type'

module Ratsit

  class RatsitRequest

    def initialize()

    end

    def exec()
      uri = self.build_uri
      conn = Faraday.new(:url => "http://#{uri.host}")
      #puts "http://#{uri.host}"
      #puts self.compose_request_body
      @response = conn.post do |req|
        req.url uri.request_uri
        req.headers['Content-Type'] = 'application/json'
        req.body = self.compose_request_body
      end
      #puts @response.body
      #puts @response.status
    end

    def response_ok
      return false if @response.nil?
      return @response.status == 200
    end

    def response_body
      return nil if @response.nil?
      return @response.body
    end
  end

  class RatsitOpenRequest < RatsitRequest

    def initialize(search_term, search_area, search_type, filters)
      super()
      if search_type == Ratsit::SEARCH_TYPE_ESTATE
        raise RatsitRequestError, 'Estate search is not available in open api'
      end
      @base_url = 'http://www.ratsit.se/BC/SearchSimple.aspx/'
      @search_term = search_term
      @search_area = search_area
      @search_type = search_type
      @search_filter = filters
      self
    end

    def build_uri
      if !Ratsit.validate_search_type(@search_type)
        raise RatsitRequestError, 'Invalid search type'
      end
      URI.parse("#{@base_url}#{@search_type}")
    end

    def compose_request_body
      {
          'who': @search_term,
          'where': @search_area,
          'filter': @search_filter.to_json
      }.to_json
    end

  end

  class RatsitTokenRequest < RatsitRequest
    def initialize()
      raise NotImplementedError, 'Token requests are not supported yet'
    end
  end

end