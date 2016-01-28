
require 'ratsit/errors'
require 'ratsit/filter/filter_get_annual_report'

describe Ratsit::Filter::GetAnnualReportFilter do

  it 'should initialize' do
    filter_instance = Ratsit::Filter::GetAnnualReportFilter.new()
    expect(filter_instance).to_not eq(nil)
  end

end