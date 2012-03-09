require 'spec_helper'

describe Trenza::Parallel do
  
  class DummyForParallel

    attr_reader :wadus_started, :wadus_finished
    
    def wadus
      @wadus_started = true
      sleep 0.2
      @wadus_finished = true
      :wadus
    end
  end
  
  let(:parallel) { DummyForParallel.new.parallel }
  
  it 'should work as usual' do
    parallel.wadus.should == :wadus
  end

  it 'should work in parallel' do
    wadus = parallel.wadus
    parallel.wadus_started.should be_true
    parallel.wadus_finished.should_not be_true
    wadus.should == :wadus
    parallel.wadus_finished.should be_true
  end
  
end