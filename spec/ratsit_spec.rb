
require 'ratsit'
require 'ratsit/errors'
require 'ratsit/filter/filter'
require 'ratsit/filter/filter_company'
require 'ratsit/filter/filter_person'

describe Ratsit do

  it 'should fail' do
    expect {
      Ratsit.OpenPersonSearch('', '', Ratsit::Filter::CompanyFilter.new())
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should fail' do
    expect {
      Ratsit.OpenCompanySearch('', '', Ratsit::Filter::PersonFilter.new())
    }.to raise_error(error=RatsitFilterError)
  end

end