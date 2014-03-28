module Chameleon
  module VM
    @@instruction_table = []

    def self.instruction_table
      @@instruction_table
    end

    def self.register_instruction(opcode, instruction)
      @@instruction_table[opcode] = instruction
    end

    def self.instruction(opcode)
      @@instruction_table[opcode]
    end

    def self.execute_instruction(opcode, engine)
      instruction(opcode).call(engine)
    end
  end
end
