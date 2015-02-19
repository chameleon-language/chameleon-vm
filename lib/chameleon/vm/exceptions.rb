module Chameleon
  module VM
    class StackUnderflowError < RuntimeError; end
    class CorruptedStackError < RuntimeError; end
    class InvalidArgumentError < RuntimeError; end
  end
end
