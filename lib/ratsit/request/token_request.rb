
require 'savon'
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
        # debug args: , log_level: :debug, log: true
        client = Savon.client(wsdl: "https://www.ratsit.se/ratsvc/apipackageservice.asmx?WSDL")
        @response = client.call(@ept.underscore.to_sym, message: @filter_instance.to_obj)
      end

    end
  end
end