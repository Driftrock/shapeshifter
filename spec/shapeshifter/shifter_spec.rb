require './lib/shapeshifter'
require 'spec_helper'
require './lib/shapeshifter'
require './spec/fixtures/test_shifter'
require './spec/fixtures/test_shifter2'

module Shapeshifter
  RSpec.describe Shifter do
    it 'should allow me to chain shifters' do
      TestShifter.chain(TestShifter2)
    end
  #TestShifter.chain(TestShifter2).transform({ :x, y: [:a, :b] }, {})
  #
  #class TestShifter < Shifter
  #  def shift(old_object, new_object)
  #    new_oib
  #  end
  #end
  end
end
