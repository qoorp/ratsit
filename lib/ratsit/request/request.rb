
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

      def parseFilterArgs(args, filter_class)
      if args.nil?
        raise RatsitFilterError, 'Invalid args to function'
      end
      if args.instance_of?(filter_class)
        return args
      end
      if args.is_a?(Hash)
        return filter_class.new(args)
      end
      raise RatsitFilterError, 'Invalid args to function'
    end

    end
  end
end