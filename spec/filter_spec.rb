
require 'ratsit/filters'
require 'json'

describe Ratsit::PersonFilter do

  default_filters = JSON.load('{"Married":true,"Unmarried":true,"Male":true,"Female":true,"CompanyEngagement":true,"NoCompanyEngagement":true,"AgeFrom":"0","AgeTo":"150"}')

  it 'should create a default instance of Ratsit::PersonFilter' do
    filter_instance = Ratsit::PersonFilter.new()
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should create a valid json output' do
    filter_instance = Ratsit::PersonFilter.new()
    expect(filter_instance.to_json).to eq(default_filters.to_json)
  end

  it 'should parse textual representations of booleans to proper bools' do
    filter_instance = Ratsit::PersonFilter.new({Ratsit::FILTER_MARRIED => 'tRuE', Ratsit::FILTER_COMPANY_ENGAGEMENT => 'True'})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should parse textual representations of booleans to proper bools 2' do
    filter_instance = Ratsit::PersonFilter.new({Ratsit::FILTER_MARRIED => 'False', Ratsit::FILTER_COMPANY_ENGAGEMENT => 'True'})
    expect(filter_instance.active_filters).to_not eq(default_filters)
    expect(filter_instance.active_filters[Ratsit::FILTER_MARRIED]).to eq(false)
  end

  it 'should parse age given as integers into strings' do
    filter_instance = Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_FROM => 0, Ratsit::FILTER_AGE_TO => 150})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should remove bad filter keys' do
    filter_instance = Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_FROM => 0, 'ABadKey' => 'some value'})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should raise error on invalid age spans' do
    expect {
      Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_FROM => 10, Ratsit::FILTER_AGE_TO => 0})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should raise error on FILTER_AGE_FROM < 0' do
    expect {
      Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_FROM => -1})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should raise error on FILTER_AGE_FROM over 150' do
    expect {
      Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_FROM => 151})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should raise error on FILTER_AGE_TO < 0' do
    expect {
      Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_TO => -1})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should raise error on FILTER_AGE_TO > 150' do
    expect {
      Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_TO => 151})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should raise error on invalid boolean value' do
    expect {
      Ratsit::PersonFilter.new({Ratsit::FILTER_MARRIED => 'asdf'})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should raise error on invalid characters in age specification' do
    expect {
      Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_FROM => 'asdf'})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should raise error on invalid age type' do
    expect {
      Ratsit::PersonFilter.new({Ratsit::FILTER_AGE_FROM => {'age' => 10}})
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should be able to update filter options' do
    filter_instance = Ratsit::PersonFilter.new()
    filter_instance.update(Ratsit::FILTER_COMPANY_ENGAGEMENT, false)
    expect(filter_instance.active_filters).to_not eq(default_filters)
    expect(filter_instance.active_filters[Ratsit::FILTER_COMPANY_ENGAGEMENT]).to eq(false)
    filter_instance.update(Ratsit::FILTER_AGE_FROM, 10)
    expect(filter_instance.active_filters[Ratsit::FILTER_AGE_FROM]).to eq('10')
  end

  it 'should be able to reset changed filter options' do
    filter_instance = Ratsit::PersonFilter.new()
    filter_instance.update(Ratsit::FILTER_COMPANY_ENGAGEMENT, false)
    expect(filter_instance.active_filters[Ratsit::FILTER_COMPANY_ENGAGEMENT]).to eq(false)
    filter_instance.reset(Ratsit::FILTER_COMPANY_ENGAGEMENT)
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should fail on invalid filter key (non string)' do
    expect {
      filter_instance = Ratsit::PersonFilter.new()
      filter_instance.update({}, '')
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should fail on nil filter key' do
    expect {
      filter_instance = Ratsit::PersonFilter.new()
      filter_instance.update(Ratsit::FILTER_COMPANY_ENGAGEMENT, nil)
    }.to raise_error(error=RatsitFilterError)
  end

  it 'should fail on non-existent filter key' do
    expect {
      filter_instance = Ratsit::PersonFilter.new()
      filter_instance.update('nonkey', false)
    }.to raise_error(error=RatsitFilterError)
  end

end

describe Ratsit::CompanyFilter do

  default_filters = JSON.load('{"AB":true,"EF":true,"HB":true,"Other":true}')

  it 'should create a default instance of Ratsit::CompanyFilter' do
    filter_instance = Ratsit::CompanyFilter.new({})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should create a valid json output' do
    filter_instance = Ratsit::CompanyFilter.new({})
    expect(filter_instance.to_json).to eq(default_filters.to_json)
  end

  it 'should remove bad filter keys' do
    filter_instance = Ratsit::CompanyFilter.new({Ratsit::FILTER_AGE_FROM => 0, 'ABadKey' => 'some value', Ratsit::FILTER_AB => true})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should parse textual representations of booleans to proper bools' do
    filter_instance = Ratsit::CompanyFilter.new({Ratsit::FILTER_AB => 'TrUE', Ratsit::FILTER_HB => 'true'})
    expect(filter_instance.active_filters).to eq(default_filters)
  end

  it 'should parse textual representations of booleans to proper bools 2' do
    filter_instance = Ratsit::CompanyFilter.new({Ratsit::FILTER_AB => 'FaLse'})
    expect(filter_instance.active_filters).to_not eq(default_filters)
    expect(filter_instance.active_filters[Ratsit::FILTER_AB]).to eq(false)
  end

  it 'should raise error on invalid bool parse' do
    expect {
      Ratsit::CompanyFilter.new({Ratsit::FILTER_AB => {}})
    }.to raise_error(error=RatsitFilterError)
  end

end

describe Ratsit::EstateFilter do

  it 'should fail' do
    expect {
      Ratsit::EstateFilter.new()
    }.to raise_error(error=NotImplementedError)
  end

end
