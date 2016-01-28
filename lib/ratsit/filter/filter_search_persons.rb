
require 'ratsit/errors'
require 'ratsit/filter/filter'

module Ratsit
  module Filter

    class SearchPersonsFilter < Ratsit::Filter::RatsitFilter
      include Ratsit::Filter

      def initialize(filters={})
        super()
        @filter_defaults = {
            FILTER_TOKEN => {:parse => method(:parse_string), :default => Ratsit.get_api_key()},
            FILTER_PACKAGES => {:parse => method(:parse_string), :default => '', :validate => method(:validate_package_types)},
            FILTER_FIRST_NAME => {:parse => method(:parse_string), :default => ''},
            FILTER_LAST_NAME => {:parse => method(:parse_string), :default => ''},
            FILTER_SSN => {:parse => method(:parse_string), :default => ''},
            FILTER_ADDRESS => {:parse => method(:parse_string), :default => ''},
            FILTER_ZIP_CODE => {:parse => method(:parse_string), :default => ''},
            FILTER_CITY => {:parse => method(:parse_string), :default => ''},
            FILTER_MUNICIPALITY => {:parse => method(:parse_string), :default => ''},
            FILTER_USE_PHONETIC_SEARCH => {:parse => method(:parse_bool), :default => false},
            FILTER_SEARCH_AGE => {:parse => method(:parse_bool), :default => false},
            FILTER_AGE_FROM => {:parse => method(:parse_age), :default => '0'},
            FILTER_AGE_TO => {:parse => method(:parse_age), :default => '150'},
            FILTER_NUMBER_OF_HITS => {:parse => method(:parse_int), :default => 100}
        }
        @active_filters = validate_filters(@filter_defaults, filters)
      end
    end

  end
end
