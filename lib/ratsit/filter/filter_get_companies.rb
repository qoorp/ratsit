
require 'ratsit/errors'
require 'ratsit/filter/filter'

module Ratsit
  module Filter

    class GetCompaniesFilter < Ratsit::Filter::RatsitFilter
      include Ratsit::Filter

      def initialize(filters={})
        super()
        @filter_defaults = {
            FILTER_TOKEN => {:parse => method(:parse_string), :default => Ratsit.get_api_key()},
            FILTER_COMPANY_NAME => {:parse => method(:parse_string), :default => ''},
            FILTER_ADDRESS => {:parse => method(:parse_string), :default => ''},
            FILTER_ZIP_CODE => {:parse => method(:parse_string), :default => ''},
            FILTER_CITY => {:parse => method(:parse_string), :default => ''},
            FILTER_PHONE => {:parse => method(:parse_string), :default => ''},
            FILTER_COMPANY_TYPE => {:parse => method(:parse_list), :default => '', :validate => method(:validate_company_types)}
        }
        @active_filters = validate_filters(@filter_defaults, filters)
      end
    end

  end
end