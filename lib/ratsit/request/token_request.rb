
require 'savon'
require 'json'
require 'ratsit/monkey'
require 'ratsit/request/request'

module Ratsit
  module Request
    # should define epts here
    class TokenRequest < Ratsit::Request::RatsitRequest

      def initialize(ept, filter_instance)
        super()
        @ept = ept
        @filter_instance = filter_instance
      end

      def exec()
        begin
          # debug args: , log_level: :debug, log: true
          url = ENV['RATSIT_WSDL_URL']
          if url.nil?
            raise RatsitRequestError, 'Missing RATSIT_WSDL_URL in env'
          end
          client = Savon.client(wsdl: url)
          @response = client.call(@ept.underscore.to_sym, message: @filter_instance.to_obj)
        rescue Savon::Error
          raise RatsitError, 'Provider error'
        end
      end

      def response_ok
        return false if @response.nil?
        return (@response.success? && !@response.soap_fault? && !@response.http_error?)
      end

    end
  end
end
