module Trenza
  module BlankSlate
    def self.included(base)
      base.send(:instance_methods).each { |m| base.send(:undef_method, m) unless m.to_s =~ /^__/ || m.to_s == 'object_id'}
    end
  end
end