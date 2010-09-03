module Cgp
  class Utility

    # This method provides useful way to loop over a range of numbers, even
    # if the maximum is not known in advance.
    #
    # The loop starts at 0 and increases to an upper bound. The upper bound
    # can change over time, as explained below.
    #
    # The loop repeats until a termination condition is met:
    #   1. an exception is raised
    #   2. max_iterations are reached, if specified
    #
    # An intended use case is to allow the cycle to repeat indefinitely.
    #
    # This method yields to a block. The block should try to find a record
    # with the index +x+. The upper bound (+max+) is increased when a match
    # is found, by an amount specified with +grow_by+.
    def self.cycle(options = {})
      max            = options[:initial_max] || 100
      grow_by        = options[:grow_by] || 100
      max_iterations = options[:max_iterations] || nil
      iterations = 0
      x = 0
      loop do
        match = yield(x)
        max = [max, x + grow_by].max if match
        iterations += 1
        break if max_iterations && iterations >= max_iterations
        x += 1
        x = 0 if x > max
      end
    end

  end
end
