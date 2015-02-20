module Chameleon
  module VM
    class Engine
      attr_reader :input, :output, :stack_pointer
      attr_accessor :pc

      alias_method :goto, :pc=

      def initialize(input: STDIN, output: STDOUT)
        @input          = input
        @output         = output
        @stack          = []
        @stack_pointer  = 0
        @variables      = []
        @pc             = 0
      end

      def run(bytecode, entry_point = 0)
        @pc = entry_point

        while bytecode[@pc]
          opcode = bytecode[@pc]
          num_of_args = Chameleon::VM.instruction_argument_count(opcode)

          args = num_of_args > 0 ? bytecode[(@pc + 1)..(@pc + num_of_args)] : []
          @pc += (num_of_args + 1)

          Chameleon::VM.execute_instruction!(opcode, args, self)
        end
      end

      def assign_variable(index, cell)
        @variables[index] = cell
      end

      def fetch_variable(index)
        @variables[index]
      end

      def push_to_stack(cell)
        @stack[@stack_pointer] = cell
        @stack_pointer += 1

        cell
      end

      def pop_from_stack
        cell = top_of_stack
        @stack_pointer -= 1

        cell
      end

      def top_of_stack(count = 1)
        if @stack.count < count
          fail Chameleon::VM::StackUnderflowError,
               %(was looking for #{count} top items,
                 but the stack has only #{@stack.count})
        end

        cells = @stack[(@stack_pointer - count)..(@stack_pointer - 1)].reverse

        cells.count == 1 ? cells.first : cells
      end
    end
  end
end
