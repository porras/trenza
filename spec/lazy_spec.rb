require 'spec_helper'

describe Trenza::Lazy do
  
  class DummyForLazy

    attr_reader :wadus_called

    def wadus
      @wadus_called = true
      :wadus
    end
  end
  
  let(:lazy) { DummyForLazy.new.lazy }
  
  it 'should work as usual' do
    lazy.wadus.should == :wadus
  end
  
  it 'should not do anything until needed' do
    wadus = lazy.wadus
    lazy.wadus_called.should_not be_true
    wadus.should == :wadus
    lazy.wadus_called.should be_true
  end
  
end