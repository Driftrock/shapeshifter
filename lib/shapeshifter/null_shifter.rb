module Shapeshifter
  class NullShifter < Shifter
    def initialize
      @first_shifter = nil
      @next_shifter = nil
    end

    def shift(_, res)
      res
    end
  end
end
