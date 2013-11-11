# Note that this program will only work for Ruby 1.9 and above. For Ruby 1.8.7
# and below you will have to change the 'arrow' syntax for defining to syntaxes
# compatible with those interpreters.

require 'minitest/spec'
require 'minitest/autorun'

# We first define lambdas for true and false expressions. 'tru' is a function
# taking one argument that returns a function accepting another function, and
# which returns the value of the outer function. 'fls' also takes one argument
# and returns a function taking a second argument, but it returns the value
# given to the second function.
#
# Note that we use a convention of indicating variables whose values are ignored
# with the '_' character.
tru = -> (x) { -> (_) { x } }
fls = -> (_) { -> (y) { y } }

# We now define a sequence of three nested lambdas corresponding to the
# conditional test followed by lambdas representing the true and the false
# "branches" in the conditional. Again this could have been represented as a
# single lambda accepting three arguments, but keep the language as simple as
# possible and to demonstrate currying and higher-order functions we implement
# the conditional by a series of one-argument lambdas.
#
# For a true expression, you can think of this in terms of the following
# evaluation:
#
#     if_then_else.call(tru).call('true expression').call('false expression')
#
# We call the if_then_else lambda with the expression that either evaluates to
# true or false. The next two invocations of 'call' are evaluated by the
# functions above (tru and fls) which return either the value given to the outer
# function or the inner function.
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
