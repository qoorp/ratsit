
require 'ratsit/errors'
require 'ratsit/filter/filter'

module Ratsit
  module Filter



    class PersonFilter < Ratsit::Filter::RatsitFilter
      include Ratsit::Filter
      #{"Married":true,"Unmarried":true,"Male":true,"Female":true,"CompanyEngagement":true,"NoCompanyEngagement":true,"AgeFrom":"0","AgeTo":"150"}
      def initialize(filters={})
        super()
        @filter_defaults = {
            FILTER_MARRIED => {:parse => method(:parse_bool), :default => true},
            FILTER_UNMARRIED => {:parse => method(:parse_bool), :default => true},
            FILTER_MALE => {:parse => method(:parse_bool), :default => true},
            FILTER_FEMALE => {:parse => method(:parse_bool), :default => true},
            FILTER_COMPANY_ENGAGEMENT => {:parse => method(:parse_bool), :default => true},
            FILTER_NO_COMPANY_ENGAGEMENT => {:parse => method(:parse_bool), :default => true},
            FILTER_AGE_FROM => {:parse => method(:parse_age), :default => '0'},
            FILTER_AGE_TO => {:parse => method(:parse_age), :default => '150'}
        }
        @active_filters = validate_filters(@filter_defaults, filters)
      end
    end

  end
end