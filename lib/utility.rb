module Cgp
  class Utility

    # This method provides useful way to loop over a range of numbers, even
    # if the maximum is not known in advance.
    #
    # The loop index starts at +options[:start]+ (typically 0) and increases
    # to an upper bound. The upper bound is originally +options[:initial_max]+
    # but can change over time, as explained below. The loop index rolls back
    # to +options[:min]+ when it exceeds the upper bound.
    #
    # This method yields to a block. The block is expected to find a record
    # with the given index parameter. The upper bound is increased by
    # +options[:grow_by]+ when a match is found.
    #
    # The loop repeats until a termination condition is met:
    #   1. the yielded block calls `break`
    #   2. max_iterations are reached, if specified
    #   3. an exception is raised
    #
    # An intended use case is to allow the cycle to repeat indefinitely. If
    # your code needs to handle linux signals and stop gracefully, please
    # manage this in the yielded block and `break` when you are ready.
    #
    def self.cycle(options = {})
      min            = options[:min]            || 0
      x              = options[:start_at]       || min
      max            = options[:initial_max]    || 100
      grow_by        = options[:grow_by]        || 50
      max_iterations = options[:max_iterations] || nil
      iterations = 0
      loop do
        match = yield(x)
        max = [max, x + grow_by].max if match
        iterations += 1
        break if max_iterations && iterations >= max_iterations
        x += 1
        x = min if x > max
      end
    end

  end
end
