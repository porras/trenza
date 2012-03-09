module Trenza
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
