
require 'ratsit/errors'

module Ratsit

  SEARCH_TYPE_PERSON  = 'PersonSearch'
  SEARCH_TYPE_COMPANY = 'CompanySearch'
  SEARCH_TYPE_ESTATE  = 'EstateSearch'

  def Ratsit.validate_search_type(search_type)
    raise RatsitError, 'Invalid search_type argument' if !search_type.is_a?(String)
    return [
        SEARCH_TYPE_PERSON,
        SEARCH_TYPE_COMPANY,
        SEARCH_TYPE_ESTATE
    ].include?(search_type)
  end

end