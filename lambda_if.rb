require 'minitest/spec'
require 'minitest/autorun'

l_true = -> (x) { -> (y) { x } }
l_false = -> (x) { -> (y) { y } }

if_then_else = -> (p) { -> (a) { -> (b) { p.call(a).call(b) } } }

describe 'Implementing conditionals in the lambda calculus' do
  describe 'the "true" lambda' do
    it 'returns the argument given to the first function' do
      l_true.call('first').call('second').must_equal 'first'
    end
  end

  describe 'the "false" lambda' do
    it 'returns the argument given to the second function' do
      l_false.call('first').call('second').must_equal 'second'
    end
  end

  describe 'if..then..else using the lambda calculus' do
    it 'returns the value of the "then" branch if the conditional is true' do
      if_then_else.call(l_true).call('true value').call('false value').
        must_equal 'true value'
    end

    it 'returns the value of the "else" branch if the conditional is false' do
      if_then_else.call(l_false).call('true value').call('false value').
        must_equal 'false value'
    end
  end
end
