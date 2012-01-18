module Trenza

  module BlankSlate
    def self.included(base)
      base.send(:instance_methods).each { |m| base.send(:undef_method, m) unless m =~ /^__/ }
    end
  end

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
        @value ||= @block.call
      end
    end
  end
  
  module ProxyBuilder
    def parallel
      Parallel.new(self)
    end
    
    def lazy
      Lazy.new(self)
    end
  end

end

include Trenza::ProxyBuilder
