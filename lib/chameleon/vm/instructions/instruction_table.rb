module Chameleon
  module VM
    @@instruction_table = []

    def self.instruction_table
      @@instruction_table
    end

    def self.register_instruction(opcode, argument_count, instruction)
      @@instruction_table[opcode] = OpenStruct.new(argument_count: argument_count,
                                                   instruction: instruction)
    end

    def self.instruction_argument_count(opcode)
      @@instruction_table[opcode].argument_count
    end

    def self.instruction(opcode)
      @@instruction_table[opcode].instruction
    end

    def self.execute_instruction!(opcode, arguments, engine)
      instruction(opcode).call(arguments, engine)
    end
  end
end
