require 'ratsit/version'
require 'ratsit/package'
require 'ratsit/search_type'
require 'ratsit/request'
require 'ratsit/filters'
require 'ratsit/errors'
require 'json'

module Ratsit

  api_key_key = 'RATSIT_API_KEY'
  @env_api_key = ENV[api_key_key]
  if @env_api_key.nil?
    puts "No api key specified. The library can only search using the open api. Set your api key using key #{api_key_key}"
  end

  class RatsitSearch

    attr_reader :filter
    attr_reader :results

    def initialize(search_type, filter_instance)
      @filter = filter_instance
      @search_type = search_type
      @results = nil
      @api_key = @env_api_key
    end

    def search(search_arg, search_area='')
      if !search_arg.is_a?(String)
        raise RatsitError, 'Invalid search argument'
      end
      if search_arg.length == 0
        raise RatsitError, 'Invalid search argument length'
      end
      if !search_area.is_a?(String)
        raise RatsitError, 'Invalid search area'
      end
      request_class = (!@api_key.nil?)? Ratsit::RatsitTokenRequest: Ratsit::RatsitOpenRequest
      @request = request_class.new(search_arg, search_area, @search_type, @filter)
      @request.exec()
      # check this...
      if @request.response_ok
        #puts "response ok"
        #@results = @request.response_body.to_json
        @results = @request.response_body
      else
        @results = nil
      end
      @results
    end

  end

  class PersonSearch < RatsitSearch

    def initialize()
      super(Ratsit::SEARCH_TYPE_PERSON, Ratsit::PersonFilter.new())
      self
    end

  end

  class CompanySearch < RatsitSearch

    def initialize()
      super(Ratsit::SEARCH_TYPE_COMPANY, Ratsit::CompanyFilter.new())
      self
    end

  end

  class EstateSearch < RatsitSearch

    def initialize()
      super(Ratsit::SEARCH_TYPE_ESTATE, Ratsit::EstateFilter.new())
      self
    end

  end

end
