
require 'faraday'
require 'uri'
require 'json'

require 'ratsit/errors'
require 'ratsit/request/request'


module Ratsit
  module Request
    OPEN_REQUEST_EPTS = {
        :person => 'PersonSearch',
        :company => 'CompanySearch'
    }
    class OpenRequest < Ratsit::Request::RatsitRequest

      def initialize(ept, search_term, search_area, filter_instance)
        if !Ratsit::Request::OPEN_REQUEST_EPTS.values.include?(ept)
          raise RatsitRequestError, 'Invalid endpoint specified'
        end
        if !search_term.instance_of?(String) || search_term.length == 0
          raise RatsitRequestError, 'Invalid search term'
        end
        if !search_area.instance_of?(String)
          raise RatsitRequestError, 'Invalid search area'
        end
        @ept = ept
        @search_area = search_area
        @search_term = search_term
        @filter_instance = filter_instance || {}
        super()
      end

      def exec
        uri = URI.parse("http://www.ratsit.se/BC/SearchSimple.aspx/#{@ept}")
        conn = Faraday.new(:url => "#{uri.scheme}://#{uri.host}")
        @response = conn.post do |req|
          req.url uri.request_uri
          req.headers['Content-Type'] = 'application/json'
          req.body = self.request_body
        end
      end

      def request_body
        {
            'who': @search_term,
            'where': @search_area,
            'filter': @filter_instance.to_json
        }.to_json
      end

      def response_ok
        return false if @response.nil?
        @response.status == 200
      end

      def response_body
        return nil if @response.nil?
        @response.body
      end

    end
  end
end