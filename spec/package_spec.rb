
require 'ratsit/package'

describe Ratsit do

  it 'should work' do
    [
        Ratsit::PACKAGE_SMALL_1,
        Ratsit::PACKAGE_SMALL_2,
        Ratsit::PACKAGE_SMALL_3,
        Ratsit::PACKAGE_REMARK,
        Ratsit::PACKAGE_MEDIUM,
        Ratsit::PACKAGE_LARGE
    ].each do |package|
      expect(Ratsit.validate_package(package)).to eq(true)
    end
  end

  it 'should fail' do
    expect(Ratsit.validate_package('asdf') == false)
  end

  it 'should raise error on invalid package type argument' do
    expect {
      Ratsit.validate_package({})
    }.to raise_error(error=RatsitError)
  end

end
