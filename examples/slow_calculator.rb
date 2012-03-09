require 'trenza'

class Calculator
  def add(a, b)
    result = a + b
    sleep 0.01 * result
    result
  end
end

def try(calc)
  z = calc.add(10, 10)
  a = calc.add(5, 7)
  b = calc.add(3, 4)
  c = calc.add(1, 2)
  d = calc.add(3, 5)
  f = calc.add(c, d)
  e = calc.add(a, b)
  g = calc.add(e, f)
  g.to_s
end

require 'benchmark'

Benchmark.bm(10) do |bm|
  bm.report("Regular")  { try Calculator.new          }
  bm.report("Lazy")     { try Calculator.new.lazy     }
  bm.report("Parallel") { try Calculator.new.parallel }
end
