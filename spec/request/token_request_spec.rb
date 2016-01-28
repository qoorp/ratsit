
require 'ratsit'
require 'ratsit/request/request'
require 'ratsit/request/token_request'

require 'ratsit/filter/filter_search_one_person'

describe Ratsit::Request::TokenRequest do

  it 'should initialize' do
    req = Ratsit::Request::TokenRequest.new('', '')
    expect(req).to_not eq(nil)
  end

=begin
  it 'should work' do
    filter = Ratsit::Filter::SearchOnePersonFilter.new({'firstName' => 'stefan', 'lastName' => 'nyman', 'packages' => 'small 1'})
    p filter.to_obj
    req = Ratsit::Request::TokenRequest.new('SearchOnePerson', filter)
    req.exec()
  end
=end

end