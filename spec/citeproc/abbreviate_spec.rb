require 'spec_helper'

module CiteProc
  describe Abbreviate do
    before { Object.class_eval { include Abbreviate } }

    let(:subject) { Object.new }
        
    describe '#abbreviations=' do
      context 'given a hash' do
        let(:abbrev) { Hash[:foo, :bar] }
        it 'uses the hash as the new set of abbreviations' do
          subject.abbreviations = abbrev
          subject.abbreviations.should == abbrev
          subject.abbreviations.should_not equal(abbrev)
        end
      end
      
      context 'given a string' do
        let(:abbrev) { '{"foo":"bar"}' }
        it 'uses the hash as the new set of abbreviations' do
          subject.abbreviations = abbrev
          subject.abbreviations.should == Hash[:foo,'bar']
        end
      end
    end
    
    describe '#abbreviate' do
    end
    
  end
end