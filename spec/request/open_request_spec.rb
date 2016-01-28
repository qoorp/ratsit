
require 'ratsit/errors'
require 'ratsit/request/request'
require 'ratsit/request/open_request'

describe Ratsit::Request::OpenRequest do

  it 'should initialize' do
    req = Ratsit::Request::OpenRequest.new(Ratsit::Request::OPEN_REQUEST_EPTS[:person], 'a', '', nil)
    expect(req).to_not eq(nil)
  end

  it 'should fail (invalid ept)' do
    expect {
      Ratsit::Request::OpenRequest.new('asdf', 'a', '', nil)
    }.to raise_error(error=RatsitRequestError)
  end

  it 'should fail (invalid search term)' do
    expect {
      Ratsit::Request::OpenRequest.new(Ratsit::Request::OPEN_REQUEST_EPTS[:person], '', '', nil)
    }.to raise_error(error=RatsitRequestError)
  end

  it 'should fail (invalid search term 2)' do
    expect {
      Ratsit::Request::OpenRequest.new(Ratsit::Request::OPEN_REQUEST_EPTS[:person], nil, '', nil)
    }.to raise_error(error=RatsitRequestError)
  end

  it 'should fail (invalid search area 2)' do
    expect {
      Ratsit::Request::OpenRequest.new(Ratsit::Request::OPEN_REQUEST_EPTS[:person], 'a', nil, nil)
    }.to raise_error(error=RatsitRequestError)
  end

  if ENV['TEST_LIVE_REQUESTS'] == 'true'

    it 'should do a person request' do
      req = Ratsit::Request::OpenRequest.new(Ratsit::Request::OPEN_REQUEST_EPTS[:person], 'Stefan Nyman', '', nil)
      req.exec()
      expect(req.response_ok).to eq(true)
    end

    it 'should do a company request' do
      req = Ratsit::Request::OpenRequest.new(Ratsit::Request::OPEN_REQUEST_EPTS[:company], 'Qoorp', '', nil)
      req.exec()
      expect(req.response_ok).to eq(true)
    end

  end

end