require 'spec_helper'

describe Trenza::Parallel do
  
  SLEEP_FACTOR = 0.01
  
  class DummyForParallel

    attr_reader :wadus_started, :wadus_finished
    
    def wadus
      @wadus_started = true
      sleep 2 * SLEEP_FACTOR
      @wadus_finished = true
      :wadus
    end
    
    def chain
      DummyForParallel.new
    end
  end
  
  let(:parallel) { DummyForParallel.new.parallel }
  
  it 'should work as usual' do
    parallel.wadus.should == :wadus
  end

  it 'should work in parallel' do
    check_parallelism parallel
  end
  
  it 'should return parallel objects' do
    check_parallelism parallel.chain
  end
  
  def check_parallelism(dummy)
    wadus = dummy.wadus
    sleep SLEEP_FACTOR
    dummy.wadus_started.should be_true
    dummy.wadus_finished.should_not be_true
    wadus.should == :wadus
    dummy.wadus_finished.should be_true
  end
  
end