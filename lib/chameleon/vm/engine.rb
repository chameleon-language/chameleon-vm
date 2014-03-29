module Chameleon
  module VM
    class Engine

      attr_reader :input, :output

      def initialize(input: STDIN, output: STDOUT)
        @input          = input
        @output         = output
        @stack          = []
        @stack_pointer  = 0
      end

      def run!(bytecode, entry_point=0)
        @pc = entry_point

        until bytecode[@pc].nil?
          opcode = bytecode[@pc]
          num_of_args = Chameleon::VM.instruction_argument_count(opcode)

          args = num_of_args.zero? ? [] : bytecode[(@pc+1)..(@pc+num_of_args+1)]

          Chameleon::VM.execute_instruction!(opcode, args, self)

          @pc += (num_of_args + 1)
        end
      end

      def push_to_stack!(cell)
        @stack[@stack_pointer] = cell
        @stack_pointer += 1

        cell
      end

      def pop_from_stack!
        cell = top_of_stack
        @stack_pointer -= 1

        cell
      end

      def top_of_stack(count=1)
        cells = @stack[(@stack_pointer-1)..(@stack_pointer-count)]

        cells.count == 1 ? cells.first : cells
      end

    end
  end
end
