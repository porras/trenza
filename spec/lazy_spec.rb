require 'spec_helper'

describe Trenza::Lazy do
  
  class DummyForLazy

    attr_reader :wadus_called

    def wadus
      @wadus_called = true
      :wadus
    end
    
    def chain
      DummyForLazy.new
    end
  end
  
  let(:lazy) { DummyForLazy.new.lazy }
  
  it 'should work as usual' do
    lazy.wadus.should == :wadus
  end
  
  it 'should not do anything until needed' do
    check_lazyness lazy
  end
  
  it 'should return lazy objects' do
    check_lazyness lazy.chain
  end
  
  def check_lazyness(dummy)
    wadus = dummy.wadus
    dummy.wadus_called.should_not be_true
    wadus.should == :wadus
    dummy.wadus_called.should be_true
  end
  
end