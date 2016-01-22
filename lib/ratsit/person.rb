
require 'ratsit/monkey'
require 'ratsit/errors'

module Ratsit

  class Person

    def initialize(json_obj)
      if !json_obj.is_a?(Hash)
        raise RatsitError, 'Invalid Person initializer'
      end
      @json_source = json_obj
      json_obj.each do |k, v|
        case k
          when 'FirstName'
            v.gsub!("<b>", "")
            v.gsub!("</b>", "")
          when 'Gender'
            v = v.gsub("icon_", "")
            v = v.gsub(".png", "")
          when 'Married'
            v = v.gsub("icon_", "")
            v = v.gsub(".png", "")
          when 'CompanyEngagement'
            v = v.gsub("icon_", "")
            v = v.gsub(".png", "")
          else
            v = v
        end
        self.class.send(:define_method, k.underscore) {
          return v
        }
      end
    end

  end

end