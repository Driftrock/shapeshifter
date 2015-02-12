require './lib/shapeshifter'
require 'spec_helper'
require './lib/shapeshifter'
require './spec/fixtures/test_shifter'
require './spec/fixtures/test_shifter2'

module Shapeshifter
  RSpec.describe Shifter do
    it 'should allow me to chain shifters' do
      expect do
        TestShifter.chain(TestShifter2)
      end.to_not raise_error
    end

    describe '::shift' do
      it 'should allow me to call shift and have it call shift on all shifters' do
        expect_any_instance_of(TestShifter).to receive(:shift).and_return({})
        expect_any_instance_of(TestShifter2).to receive(:shift).and_return({})
        TestShifter.chain(TestShifter2).shift({}, {})
      end
    end

    describe '::revert' do
      it 'should allow me to call revert and have it call revert on all shifters' do
        expect_any_instance_of(TestShifter).to receive(:revert).and_return({})
        expect_any_instance_of(TestShifter2).to receive(:revert).and_return({})
        TestShifter.chain(TestShifter2).revert({}, {})
      end
    end

    context 'when a shift is made' do
      before do
        test_shifter = double(TestShifter)
        allow(TestShifter).to receive(:new).and_return(test_shifter)
        allow(test_shifter).to receive(:shift) do |target|
          target[:a] = Array(target[:a]).concat(target[:b])
          target
        end
      end

      it 'should change the passed target' do
        target = { a: 1, b: [2, 3] }
        expect do
          TestShifter.shift({}, target)
        end.to change { target }.to eq ({ a: [1, 2, 3], b: [2, 3] })
      end
    end
  #
  #class TestShifter < Shifter
  #  def shift(old_object, new_object)
  #    new_oib
  #  end
  #end
  end
end
