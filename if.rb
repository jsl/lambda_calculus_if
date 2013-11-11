require 'minitest/spec'
require 'minitest/autorun'

tru = -> (x) { -> (y) { x } }
fls = -> (x) { -> (y) { y } }

if_then_else = -> (p) { -> (a) { -> (b) { p.call(a).call(b) } } }

describe 'Implementing conditionals in the lambda calculus' do
  describe 'the tru (true) lambda expression' do
    it 'returns the argument given to the first function' do
      tru.call('first').call('second').must_equal 'first'
    end
  end

  describe 'the fls (false) lambda expression' do
    it 'returns the argument given to the second function' do
      fls.call('first').call('second').must_equal 'second'
    end
  end

  describe 'if..then..else using the lambda calculus' do
    it 'returns the value of the "then" branch if the conditional is true' do
      if_then_else.call(tru).call('true value').call('false value').
        must_equal 'true value'
    end

    it 'returns the value of the "else" branch if the conditional is false' do
      if_then_else.call(fls).call('true value').call('false value').
        must_equal 'false value'
    end
  end
end
