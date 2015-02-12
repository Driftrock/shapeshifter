module Shapeshifter
  class ShiftChain
    def initialize(first)
      @shifters = [first]
    end

    def chain(shifter)
      shifters << shifter
      self
    end

    def shift(source_object, target_object)
      can_be_dupped = source_object.respond_to?(:dup)
      shifters.each do |shifter_class|
        so = can_be_dupped ? source_object.dup : source_object
        shifter = shifter_class.new(so)
        target_object = shifter.shift(target_object)
      end
      target_object
    end

    def revert(source_object, target_object)
      can_be_dupped = source_object.respond_to?(:dup)
      shifters.reverse.each do |shifter_class|
        so = can_be_dupped ? source_object.dup : source_object
        shifter = shifter_class.new(so)
        target_object = shifter.revert(target_object)
      end
      target_object
    end

    private

    attr_reader :shifters
  end
end
