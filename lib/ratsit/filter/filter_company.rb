

require 'ratsit/errors'
require 'ratsit/filter/filter'

module Ratsit
  module Filter



    class CompanyFilter < Ratsit::Filter::RatsitFilter
      include Ratsit::Filter
      #{"AB":true,"EF":true,"HB":true,"Other":true}
      def initialize(filters={})
        super()
        @filter_defaults = {
            FILTER_AB => {:parse => method(:parse_bool), :default => true},
            FILTER_EF => {:parse => method(:parse_bool), :default => true},
            FILTER_HB => {:parse => method(:parse_bool), :default => true},
            FILTER_OTHER => {:parse => method(:parse_bool), :default => true}
        }
        @active_filters = validate_filters(@filter_defaults, filters)
      end
    end

  end
end