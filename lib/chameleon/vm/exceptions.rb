module Chameleon
  module VM
    class StackUnderflowError < RuntimeError; end
    class CorruptedStackError < RuntimeError; end
    class InvalidArgumentError < RuntimeError; end
    class InvalidVariableTypeError < RuntimeError; end
  end
end
