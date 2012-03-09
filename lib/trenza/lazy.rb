module Trenza
  class Lazy
    include BlankSlate
  
    def initialize(object)
      @object = object
    end

    def method_missing(meth, *args, &blk)
      MethodCall.new do
        @object.send meth, *args, &blk
      end
    end

    class MethodCall
      include BlankSlate
    
      def initialize(&block)
        @block = block
      end
    
      def method_missing(meth, *args, &blk)
        value.send meth, *args, &blk
      end
    
      def value
        @value ||= @block.call.lazy
      end
    end
  end
end