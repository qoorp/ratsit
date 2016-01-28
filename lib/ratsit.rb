
require 'ratsit/errors'
require 'ratsit/monkey'
require 'ratsit/version'

require 'ratsit/filter/filter'
require 'ratsit/filter/filter_company'
require 'ratsit/filter/filter_get_annual_report'
require 'ratsit/filter/filter_get_companies'
require 'ratsit/filter/filter_get_company_information_package'
require 'ratsit/filter/filter_get_person_information_package'
require 'ratsit/filter/filter_person'
require 'ratsit/filter/filter_search_one_person'
require 'ratsit/filter/filter_search_persons'

require 'ratsit/request/request'
require 'ratsit/request/open_request'
require 'ratsit/request/token_request'


module Ratsit

  def Ratsit.get_api_key
    key_key = 'RATSIT_API_KEY'
    if ENV[key_key].nil?
      raise RatsitError, 'No api key specified'
    end
    return ENV[key_key]
  end

  def Ratsit.OpenPersonSearch(search_term, search_area, filter_instance=nil)
    if !filter_instance.nil? && !filter_instance.instance_of?(Ratsit::Filter::PersonFilter)
      raise RatsitFilterError, 'Invalid filter given to function'
    end
    req = Ratsit::Request::OpenRequest.new(Ratsit::Request::OPEN_REQUEST_EPTS[:person], search_term, search_area, filter_instance || Ratsit::Filter::PersonFilter.new())
    req.exec()
    if req.response_ok
      return req.response_body
    end
    nil
  end

  def Ratsit.OpenCompanySearch(search_term, search_area, filter_instance=nil)
    if !filter_instance.nil? && !filter_instance.instance_of?(Ratsit::Filter::CompanyFilter)
      raise RatsitFilterError, 'Invalid filter given to function'
    end
    req = Ratsit::Request::OpenRequest.new(Ratsit::Request::OPEN_REQUEST_EPTS[:company], search_term, search_area, filter_instance || Ratsit::Filter::CompanyFilter.new())
    req.exec()
    if req.response_ok
      return req.response_body
    end
    nil
  end

  def Ratsit.parseFilterArgs(args, filter_class)
    if args.nil?
      raise RatsitFilterError, 'Invalid args to function'
    end
    if args.instance_of?(filter_class)
      return args
    end
    if args.is_a?(Hash)
      return filter_class.new(args)
    end
    raise RatsitFilterError, 'Invalid args to function'
  end

  def Ratsit.doTokenRequest(ept, filter_instance)
    req = Ratsit::Request::TokenRequest.new(ept, filter_instance)
    req.exec()
    if req.response_ok
      return req.response_body
    end
    nil
  end

  def Ratsit.GetAnnualReport(args=nil)
    return Ratsit.doTokenRequest('GetAnnualReport', Ratsit.parseFilterArgs(args, Ratsit::Filter::GetAnnualReportFilter))
  end

  def Ratsit.GetCompanies(args=nil)
    return Ratsit.doTokenRequest('GetCompanies', Ratsit.parseFilterArgs(args, Ratsit::Filter::GetCompaniesFilter))
  end

  def Ratsit.GetCompanyInformationPackage(args=nil)
    return Ratsit.doTokenRequest('GetCompanyInformationPackage', Ratsit.parseFilterArgs(args, Ratsit::Filter::GetCompanyInformationPackageFilter))
  end

  def Ratsit.GetPersonInformationPackage(args=nil)
    return Ratsit.doTokenRequest('GetPersonInformationPackage', Ratsit.parseFilterArgs(args, Ratsit::Filter::GetPersonInformationPackageFilter))
  end

  def Ratsit.SearchOnePerson(args=nil)
    return Ratsit.doTokenRequest('SearchOnePerson', Ratsit.parseFilterArgs(args, Ratsit::Filter::SearchOnePersonFilter))
  end

  def Ratsit.SearchPersons(args=nil)
    return Ratsit.doTokenRequest('SearchPersons', Ratsit.parseFilterArgs(args, Ratsit::Filter::SearchPersonsFilter))
  end

end
