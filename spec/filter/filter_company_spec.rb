
require 'json'
require 'ratsit/errors'
require 'ratsit/filter/filter'
require 'ratsit/filter/filter_company'

describe Ratsit::Filter::CompanyFilter do

  default_filters = JSON.load('{"AB":true,"EF":true,"HB":true,"Other":true}')

  it 'should create a default instance of Ratsit::CompanyFilter' do
    filter_instance = Ratsit::Filter::CompanyFilter.new({})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should create a valid json output' do
    filter_instance = Ratsit::Filter::CompanyFilter.new({})
    expect(filter_instance.to_json).to eq(default_filters.to_json)
  end

  it 'should remove bad filter keys' do
    filter_instance = Ratsit::Filter::CompanyFilter.new({Ratsit::Filter::FILTER_AGE_FROM => 0, 'ABadKey' => 'some value', Ratsit::Filter::FILTER_AB => true})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should parse textual representations of booleans to proper bools' do
    filter_instance = Ratsit::Filter::CompanyFilter.new({Ratsit::Filter::FILTER_AB => 'TrUE', Ratsit::Filter::FILTER_HB => 'true'})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should parse textual representations of booleans to proper bools 2' do
    filter_instance = Ratsit::Filter::CompanyFilter.new({Ratsit::Filter::FILTER_AB => 'FaLse'})
    expect(filter_instance.active_filters).to_not eq(default_filters)
    expect(filter_instance.active_filters[Ratsit::Filter::FILTER_AB]).to eq(false)
  end

  it 'should raise error on invalid bool parse' do
    expect {
      Ratsit::Filter::CompanyFilter.new({Ratsit::Filter::FILTER_AB => {}})
    }.to raise_error(error=RatsitFilterError)
  end

end