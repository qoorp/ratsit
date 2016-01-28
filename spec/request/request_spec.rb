
require 'ratsit/request/request'

describe Ratsit::Request::RatsitRequest do

  it 'should not initialize' do
    expect {
      Ratsit::Request::RatsitRequest.new()
    }.to raise_error(error=RatsitAbstractError)
  end

end
