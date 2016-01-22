
require 'ratsit'

describe Ratsit do

  it 'should perform a basic search' do
    psr = Ratsit::PersonSearch.new
    psr.search('Stefan Nyman')
    psr.filter.update(Ratsit::FILTER_COMPANY_ENGAGEMENT)
    #puts psr.results
  end

end
