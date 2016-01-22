
require 'ratsit/request'
require 'ratsit/search_type'
require 'ratsit/filters'

describe Ratsit::RatsitOpenRequest do

  it 'should search for a person' do
    req = Ratsit::RatsitOpenRequest.new('Stefan Nyman', '', Ratsit::SEARCH_TYPE_PERSON, Ratsit::PersonFilter.new())
    req.exec()
    expect(req.response_ok).to eq(true)
    expect(req.response_body).to_not eq(nil)
  end

  it 'should search for a company' do
    req = Ratsit::RatsitOpenRequest.new('Sj AB', '', Ratsit::SEARCH_TYPE_COMPANY, Ratsit::CompanyFilter.new())
    req.exec()
    expect(req.response_ok).to eq(true)
    expect(req.response_body).to_not eq(nil)
  end

  it 'should fail for estate searches with open request' do
    expect {
      Ratsit::RatsitOpenRequest.new('Sj AB', '', Ratsit::SEARCH_TYPE_ESTATE, nil)
    }.to raise_error(error=RatsitRequestError)
  end

end
