class Utility

  # Loops from 0 to a large number, repeating until a termination condition
  # is met:
  #   1. an exception is raised
  #   2. max_iterations are reached
  #
  # The interesting part of this method is grows the upper bound as needed.
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
