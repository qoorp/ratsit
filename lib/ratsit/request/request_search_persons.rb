
require 'json'

require 'ratsit/errors'
require 'ratsit/request/request'
require 'ratsit/request/token_request'

require 'ratsit/filter/filter_search_persons'

=begin
{"search_persons_response":
  {"search_persons_result":
    {"ratsit_response_package":
      {"person_search_result":
        {"hits":
          {"hit": Array || Object

=end

module Ratsit
  module Request
    class SearchPersonsRequest < Ratsit::Request::TokenRequest

      def initialize(args)
        super('SearchPersons', parseFilterArgs(args, Ratsit::Filter::SearchPersonsFilter))
      end

      def response
        if response_ok
          rsp = @response.body[:search_persons_response][:search_persons_result][:ratsit_response_package][:person_search_result]
          if rsp.nil?
            raise RatsitError, 'Invalid response from service'
          end
          if rsp[:hits].nil?
            return {
                :retrieved => 0,
                :persons => []
            }
          end
          rsp = rsp[:hits][:hit]
          if rsp.is_a?(Hash)
            rsp = [rsp]
          end
          return {
              :retrieved => rsp.length,
              :persons => rsp
          }
        end
        raise RatsitError, 'Response not ready'
      end

    end
  end
end
