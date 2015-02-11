module Shapeshifter
  class Shifter
    attr_accessor :first_shifter, :next_shifter


    def initialize
      @first_shifter = self
      @next_shifter = NullShifter.new
    end

    class << self
      def chain(shifter)
        self.new.chain(shifter)
      end
    end

    def chain(shifter)
      shifter = shifter.new if shifter.is_a?(Class)
      shifter.first_shifter = first_shifter
      @next_shifter = shifter
      shifter
    end

    def transform(start_object, end_object)
      current = self.first_shifter
      result = end_object
      begin
        result = first_shifter.shift(start_object.dup, result)
      end while current.next?
      result
    end
    
    def shift(_, _)
      raise NoMethodError.new('Should be overridden')
    end

    def next?
      !next_shifter.nil?
    end
  end
end
