
require 'ratsit/errors'


module Ratsit
  module Request
    class RatsitRequest

      def abstract(msg=nil)
        _msg = msg || 'This class should not be used directly'
        raise RatsitAbstractError, _msg
      end

      def initialize()
        @abstract_interface_msg = 'This interface is abstract. Implement method in subclass'
        if self.instance_of?(RatsitRequest)
          abstract
        end
      end

      def exec()
        abstract @abstract_interface_msg
      end

      def response_ok
        abstract @abstract_interface_msg
      end

      def response_body
        abstract @abstract_interface_msg
      end

    end
  end
end