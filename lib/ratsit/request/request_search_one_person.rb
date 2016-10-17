
require 'json'

require 'ratsit/errors'
require 'ratsit/request/request'
require 'ratsit/request/token_request'

require 'ratsit/filter/filter_search_one_person'

=begin
{
  :search_one_person_response =>
    {:search_one_person_result =>
      {:ratsit_response_package =>
        {:person_search_result =>
          {:hits =>
            {:hit=>
=end

module Ratsit
  module Request
    class SearchOnePersonRequest < Ratsit::Request::TokenRequest

      def initialize(args)
        super('SearchOnePerson', parseFilterArgs(args, Ratsit::Filter::SearchOnePersonFilter))
      end

      def response
        if response_ok
          hits = @response.body[:search_one_person_response][:search_one_person_result][:ratsit_response_package][:person_search_result][:hits]
          if hits.nil?
            return nil
          end
          rsp = hits[:hit] || nil
          if rsp.nil?
            raise RatsitError, 'Invalid response from service'
          end
          return rsp
        end
        raise RatsitError, 'Response not ready'
      end

    end
  end
end
