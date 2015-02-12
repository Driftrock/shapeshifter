module Shapeshifter
  class Shifter
    attr_reader :source_object

    def initialize(source_object)
      @source_object = source_object
    end

    class << self
      def chain(shifter)
        ShiftChain.new(self).chain(shifter)
      end

      def shift(source_object, target_object)
        ShiftChain.new(self).shift(source_object, target_object)
      end

      def revert(source_object, target_object)
        ShiftChain.new(self).revert(source_object, target_object)
      end
    end
    
    def shift(_)
      raise NoMethodError.new('Should be overridden')
    end

    def revert(_)
      raise NoMethodError.new('Should be overridden')
    end
  end
end
