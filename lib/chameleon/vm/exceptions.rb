module Chameleon
  module VM
    class StackUnderflowError < RuntimeError; end
    class CorruptedStackError < RuntimeError; end
  end
end
