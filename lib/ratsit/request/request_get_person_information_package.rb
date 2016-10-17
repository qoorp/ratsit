
require 'json'

require 'ratsit/errors'
require 'ratsit/request/request'
require 'ratsit/request/token_request'

require 'ratsit/filter/filter_get_person_information_package'

=begin
{
  :get_person_information_package_response =>
    {:get_person_information_package_result =>
      {:ratsit_response_package =>
        {:person_search_result => {}
=end

module Ratsit
  module Request
    class GetPersonInformationPackageRequest < Ratsit::Request::TokenRequest

      def initialize(args)
        super('GetPersonInformationPackage', parseFilterArgs(args, Ratsit::Filter::GetPersonInformationPackageFilter))
      end

      def response
        if response_ok
          hits = @response.body[:get_person_information_package_response][:get_person_information_package_result][:ratsit_response_package][:person_search_result]
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
