
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
require 'ratsit/request/request_get_companies'
require 'ratsit/request/request_search_one_person'
require 'ratsit/request/request_search_persons'
require 'ratsit/request/request_get_person_information_package'


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

  def Ratsit.doTokenRequest(req_class, filter_args)
    req = req_class.new(filter_args)
    puts req
    req.exec()
    return req.response
  end

  def Ratsit.SearchCompanies(args=nil)
    return Ratsit.doTokenRequest(Ratsit::Request::GetCompaniesRequest, args)
  end

  def Ratsit.SearchOnePerson(args=nil)
    return Ratsit.doTokenRequest(Ratsit::Request::SearchOnePersonRequest, args)
  end

  def Ratsit.SearchPersons(args=nil)
    return Ratsit.doTokenRequest(Ratsit::Request::SearchPersonsRequest, args)
  end

  def Ratsit.GetPersonInformationPackage(args=nil)
    return Ratsit.doTokenRequest(Ratsit::Request::GetPersonInformationPackageRequest, args)
  end
end

=begin
  def Ratsit.GetAnnualReport(args=nil)
    return Ratsit.doTokenRequest('GetAnnualReport', Ratsit.parseFilterArgs(args, Ratsit::Filter::GetAnnualReportFilter))
  end

  def Ratsit.GetCompanies(args=nil)
    return Ratsit.doTokenRequest('GetCompanies', Ratsit.parseFilterArgs(args, Ratsit::Filter::GetCompaniesFilter))
  end

  def Ratsit.GetCompanyInformationPackage(args=nil)
    return Ratsit.doTokenRequest('GetCompanyInformationPackage', Ratsit.parseFilterArgs(args, Ratsit::Filter::GetCompanyInformationPackageFilter))
  end



  def Ratsit.SearchOnePerson(args=nil)
    return Ratsit.doTokenRequest('SearchOnePerson', Ratsit.parseFilterArgs(args, Ratsit::Filter::SearchOnePersonFilter))
  end

  def Ratsit.SearchPersons(args=nil)
    return Ratsit.doTokenRequest('SearchPersons', Ratsit.parseFilterArgs(args, Ratsit::Filter::SearchPersonsFilter))
  end
=end
