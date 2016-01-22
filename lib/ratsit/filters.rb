
require 'ratsit/errors'
require 'json'

module Ratsit

  # Person filters
  FILTER_MARRIED = 'Married'
  FILTER_UNMARRIED = 'Unmarried'
  FILTER_MALE = 'Male'
  FILTER_FEMALE = 'Female'
  FILTER_COMPANY_ENGAGEMENT = 'CompanyEngagement'
  FILTER_NO_COMPANY_ENGAGEMENT = 'NoCompanyEngagement'
  FILTER_AGE_FROM = 'AgeFrom'
  FILTER_AGE_TO = 'AgeTo'

  # Company filters
  FILTER_AB = 'AB'
  FILTER_EF = 'EF'
  FILTER_HB = 'HB'
  FILTER_OTHER = 'Other'


  class RatsitFilter

    def initialize()
      @active_filters = {}
      @filter_defaults = {}
    end

    def active_filters
      return (@active_filters.nil?)? nil: @active_filters
    end

    def to_json
      af = self.active_filters
      return '{}' if af.nil?
      af.to_json
    end

    def update(filter_key='', filter_value)
      #puts "update #{filter_key}: #{filter_value}"
      if !filter_key.is_a?(String)
        raise RatsitFilterError, 'Invalid filter key'
      end
      if filter_value.nil?
        raise RatsitFilterError, 'Invalid filter value'
      end
      if !@active_filters.has_key?(filter_key)
        raise RatsitFilterError, 'Non-existent filter key'
      end
      @curr_filters = Marshal.load(Marshal.dump(@active_filters))
      @curr_filters[filter_key] = filter_value
      @active_filters = validate_filters(@filter_defaults, @curr_filters)
    end

    def reset(filter_name='')
      if !filter_name.is_a?(String)
        raise RatsitFilterError, 'Invalid filter key'
      end
      if !@filter_defaults.has_key?(filter_name)
        raise RatsitFilterError, 'Non-existent filter key'
      end
      @active_filters[filter_name] = @filter_defaults[filter_name][:default]
    end

  end

  class PersonFilter < RatsitFilter
    include Ratsit
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

  class CompanyFilter < RatsitFilter
    include Ratsit
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

  class EstateFilter < RatsitFilter
    include Ratsit
    def initialize()
      raise NotImplementedError, 'Functionality doesn\'t exist'
    end
  end

  private

  def parse_bool(arg)
    return arg if arg.is_a?(TrueClass) || arg.is_a?(FalseClass)
    raise RatsitFilterError, 'Invalid bool representation' if !arg.is_a?(String)
    return true if arg.downcase == 'true'
    return false if arg.downcase == 'false'
    raise RatsitFilterError, 'Invalid textual bool value'
  end

  def parse_age(arg)
    if arg.is_a?(String)
      if !(arg =~ /^[0-9]+$/)
        raise RatsitFilterError, 'Invalid age in filter'
      end
      larg = arg.to_i
    elsif arg.is_a?(Integer)
      larg = arg
    else
      raise RatsitFilterError, 'Invalid arg type in filter'
    end
    # ratsit specifies these ages.
    if larg < 0 || larg > 150
      raise RatsitFilterError, 'Invalid age'
    end
    return "#{larg}"
  end

  def validate_filters(filter_defaults={}, filters={})
    if !filters.is_a?(Hash)
      filters = {}
    end
    filters.reject! { |k,_| !filter_defaults.keys.include? k }
    filter_defaults.each do |filter_name, defs|
      if !filters.keys.include? filter_name
        filters[filter_name] = defs[:default]
      end
      filters[filter_name] = defs[:parse].call(filters[filter_name])
    end
    if filters[FILTER_AGE_TO].to_i < filters[FILTER_AGE_FROM].to_i
      raise RatsitFilterError, 'Invalid age span'
    end
    return filters
  end

end