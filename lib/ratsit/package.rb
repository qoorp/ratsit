
module Ratsit
  PACKAGE_SMALL_1 = 'small 1'
  PACKAGE_SMALL_2 = 'small 2'
  PACKAGE_SMALL_3 = 'small 3'
  PACKAGE_REMARK  = 'anmarkning'
  PACKAGE_MEDIUM  = 'medium'
  PACKAGE_LARGE   = 'large'

  def Ratsit.validate_package(package)
    raise RatsitError, 'Invalid package argument type' if !package.is_a?(String)
    return [
        PACKAGE_SMALL_1,
        PACKAGE_SMALL_2,
        PACKAGE_SMALL_3,
        PACKAGE_REMARK,
        PACKAGE_MEDIUM,
        PACKAGE_LARGE
    ].include?(package)
  end

end