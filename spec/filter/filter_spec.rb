
require 'ratsit/errors'
require 'ratsit/filter/filter'

describe Ratsit::Filter::RatsitFilter do

  it 'should not initialize' do
    expect {
      Ratsit::Filter::RatsitFilter.new()
    }.to raise_error(error=RatsitAbstractError)
  end

end