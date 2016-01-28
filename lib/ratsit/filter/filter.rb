
require 'json'
require 'ratsit/errors'

module Ratsit
  module Filter

    # Person filters
    FILTER_MARRIED = 'Married'
    FILTER_UNMARRIED = 'Unmarried'
    FILTER_MALE = 'Male'
    FILTER_FEMALE = 'Female'
    FILTER_COMPANY_ENGAGEMENT = 'CompanyEngagement'
    FILTER_NO_COMPANY_ENGAGEMENT = 'NoCompanyEngagement'
    FILTER_AGE_FROM = 'AgeFrom'
    FILTER_AGE_TO = 'AgeTo'

    FILTER_FIRST_NAME = 'firstName'
    FILTER_LAST_NAME = 'lastName'
    FILTER_SSN = 'ssn'
    FILTER_USE_PHONETIC_SEARCH = 'usePhoneticSearch'

    # Company filters
    FILTER_AB = 'AB'
    FILTER_EF = 'EF'
    FILTER_HB = 'HB'
    FILTER_KB = 'KB'
    FILTER_HB_KB = "#{FILTER_HB}/#{FILTER_KB}"
    FILTER_OTHER = 'Other'


    # token filters
    FILTER_TOKEN = 'token'
    FILTER_IDS = 'IDs'
    FILTER_COMPANY_NAME = 'companyName'
    FILTER_ADDRESS = 'address'
    FILTER_ZIP_CODE = 'zipCode'
    FILTER_CITY = 'city'
    FILTER_MUNICIPALITY = 'municipality'
    FILTER_PHONE = 'phone'
    FILTER_COMPANY_TYPE = 'companyType'
    FILTER_SEARCH_AGE = 'searchAge'

    FILTER_PACKAGES = 'packages'
    FILTER_ORG_NR = 'orgnr'
    FILTER_PNR = 'pnr'

    FILTER_NUMBER_OF_HITS = 'numberOfHits'

    FILTER_PACKAGE_SMALL_1 = 'small 1'
    FILTER_PACKAGE_SMALL_2 = 'small 2'
    FILTER_PACKAGE_SMALL_3 = 'small 3'
    FILTER_PACKAGE_REMARK = 'anmärkning'
    FILTER_PACKAGE_MEDIUM = 'medium'
    FILTER_PACKAGE_LARGE = 'large'

    class RatsitFilter

      def abstract(msg=nil)
        _msg = msg || 'This class should not be used directly'
        raise RatsitAbstractError, _msg
      end

      def initialize()
        @abstract_interface_msg = 'This interface is abstract. Implement method in subclass'
        if self.instance_of?(RatsitFilter)
          abstract
        end
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

      def to_obj
        @active_filters
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

    private

    def parse_string(arg)
      return arg if arg.is_a?(String)
      raise RatsitFilterError, 'Invalid string'
    end

    def parse_bool(arg)
      return arg if arg.is_a?(TrueClass) || arg.is_a?(FalseClass)
      raise RatsitFilterError, 'Invalid bool representation' if !arg.is_a?(String)
      return true if arg.downcase == 'true'
      return false if arg.downcase == 'false'
      raise RatsitFilterError, 'Invalid textual bool value'
    end

    def parse_bool_string(arg)
      return arg if arg == 'true' || arg == 'false'
      return 'true' if arg.is_a?(TrueClass)
      return 'false' if arg.is_a?(FalseClass)
      raise RatsitFilterError, 'Invalid string representation of bool'
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
      "#{larg}"
    end

    def parse_int(arg)
      return arg if arg.is_a?(Integer)
      return arg.to_i if arg =~ /^[0-9]+$/
      raise RatsitFilterError, 'Invalid integer'
    end

    def parse_list(arg)
      return arg.join(',') if arg.is_a?(Array)
      return arg if arg.is_a?(String)
      raise RatsitFilterError, 'Invalid array'
    end

    def validate_list(lst, accepted_values=[])
      if lst.is_a?(Array)
        arr = lst
      elsif lst.is_a?(String)
        arr = lst.split(',').map(&:strip)
      end
      err = []
      arr.each { |v| err.push(v) if !accepted_values.include?(v) }
      if err.length > 0
        raise RatsitFilterError, "Invalid list values: #{err.join(',')}"
      end
      arr.join(',')
    end

    def validate_company_types(lst)
      return validate_list(lst, [FILTER_AB, FILTER_EF, FILTER_HB_KB, FILTER_OTHER])
    end

    def validate_package_types(lst)
      return validate_list(lst, [FILTER_PACKAGE_SMALL_1, FILTER_PACKAGE_SMALL_2, FILTER_PACKAGE_SMALL_3, FILTER_PACKAGE_REMARK, FILTER_PACKAGE_MEDIUM, FILTER_PACKAGE_LARGE])
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
        if defs.has_key?(:validate)
          filters[filter_name] = defs[:validate].call(filters[filter_name])
        end
      end
      if filters.keys.include?(FILTER_AGE_TO) && filters.keys.include?(FILTER_AGE_FROM)
        if filters[FILTER_AGE_TO].to_i < filters[FILTER_AGE_FROM].to_i
          raise RatsitFilterError, 'Invalid age span'
        end
      end
      filters
    end

  end
end