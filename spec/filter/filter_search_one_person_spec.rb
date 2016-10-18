
require 'ratsit'
require 'ratsit/errors'
require 'ratsit/filter/filter_search_one_person'

describe Ratsit::Filter::SearchOnePersonFilter do

  it 'should initialize' do
    Ratsit::Filter::SearchOnePersonFilter.new({'packages' => 'small 1'})
  end

  it 'should throw error due to invalid packages' do
    expect {
      Ratsit::Filter::SearchOnePersonFilter.new({'packages' => 'small 12'})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should throw error due to invalid packages 2' do
    expect {
      Ratsit::Filter::SearchOnePersonFilter.new({'packages' => 'small 1,test'})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should accept a valid packages list' do
    filter_instance = Ratsit::Filter::SearchOnePersonFilter.new({'packages' => 'Small 1, Small 2'})
    expect(filter_instance.active_filters[Ratsit::Filter::FILTER_PACKAGES]).to eq('Small 1, Small 2')
  end

end
