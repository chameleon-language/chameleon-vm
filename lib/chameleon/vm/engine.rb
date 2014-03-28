module Chameleon
  module VM
    class Engine

      attr_reader :input, :output

      def initialize(input: STDIN, output: STDOUT)
        @input = input
        @output = output
      end

      def run!(bytecode)
      end

    end
  end
end
