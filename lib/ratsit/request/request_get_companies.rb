
require 'json'

require 'ratsit/errors'
require 'ratsit/request/request'
require 'ratsit/request/token_request'

require 'ratsit/filter/filter_get_companies'


=begin
{"get_companies_response":{
    "get_companies_result":{
       "ratsit_response_package":{
          "retreived":"92",
          "total_matched":"92",
          "company":[
=end

module Ratsit
  module Request
    class GetCompaniesRequest < Ratsit::Request::TokenRequest

      def initialize(args)
        super('GetCompanies', parseFilterArgs(args, Ratsit::Filter::GetCompaniesFilter))
      end

      def response
        if response_ok
          rsp = @response.body[:get_companies_response][:get_companies_result][:ratsit_response_package] || nil
          if rsp.nil?
            raise RatsitError, 'Invalid response from service'
          end
          # :retreived (sic!)
          return {
              :retrieved => rsp[:retreived].to_i,
              :total_matched => rsp[:total_matched].to_i,
              :companies => rsp[:company]
          }
        end
        raise RatsitError, 'Response not ready'
      end

    end
  end
end