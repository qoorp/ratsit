
require 'ratsit/search_type'

describe Ratsit do

  it 'should work' do
    [
        Ratsit::SEARCH_TYPE_PERSON,
        Ratsit::SEARCH_TYPE_COMPANY,
        Ratsit::SEARCH_TYPE_COMPANY
    ].each do |search_type|
      expect(Ratsit.validate_search_type(search_type)).to eq(true)
    end
  end

  it 'should fail' do
    expect(Ratsit.validate_search_type('asdf') == false)
  end

  it 'should raise error on invalid argument' do
    expect {
      Ratsit.validate_search_type({})
    }.to raise_error(error=RatsitError)
  end

end
