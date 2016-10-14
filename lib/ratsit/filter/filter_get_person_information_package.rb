
require 'ratsit/errors'
require 'ratsit/filter/filter'

module Ratsit
  module Filter

    class GetPersonInformationPackageFilter < Ratsit::Filter::RatsitFilter
      include Ratsit::Filter

      def initialize(filters={})
        super()
        @filter_defaults = {
            FILTER_TOKEN => {:parse => method(:parse_string), :default => Ratsit.get_api_key()},
            FILTER_PACKAGES => {:parse => method(:parse_list), :default => '', :validate => method(:validate_package_types)},
            FILTER_PNR => {:parse => method(:parse_string), :default => ''}
        }
        puts filters
        @active_filters = validate_filters(@filter_defaults, filters)
      end
    end

  end
end
