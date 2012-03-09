module Trenza
  class Parallel
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
        @thread = Thread.new(&block)
      end
    
      def method_missing(meth, *args, &blk)
        @thread.value.send(meth, *args, &blk)
      end
    end
  end
end