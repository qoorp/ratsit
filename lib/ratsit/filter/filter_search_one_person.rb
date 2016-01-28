
require 'ratsit/errors'
require 'ratsit/filter/filter'

module Ratsit
  module Filter

    class SearchOnePersonFilter < Ratsit::Filter::RatsitFilter
      include Ratsit::Filter

      def initialize(filters={})
        super()
        @filter_defaults = {
            FILTER_TOKEN => {:parse => method(:parse_string), :default => Ratsit.get_api_key()},
            FILTER_PACKAGES => {:parse => method(:parse_list), :default => '', :validate => method(:validate_package_types)},
            FILTER_FIRST_NAME => {:parse => method(:parse_string), :default => ''},
            FILTER_LAST_NAME => {:parse => method(:parse_string), :default => ''},
            FILTER_SSN => {:parse => method(:parse_string), :default => ''},
            FILTER_USE_PHONETIC_SEARCH => {:parse => method(:parse_bool_string), :default => 'false'}
        }
        @active_filters = validate_filters(@filter_defaults, filters)
      end
    end

  end
end
