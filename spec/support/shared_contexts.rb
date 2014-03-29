shared_context "instruction related" do
  let(:engine) { double 'engine', push_to_stack!: stack_top,
                                  top_of_stack: stack_top,
                                  pop_from_stack!: stack_pop,
                                  output: double('output').as_null_object,
                                  input: double('input', gets: gets_value) }

  let(:stack_top) { double 'cell', type: stack_top_type, value: stack_top_value }
  let(:stack_pop) { stack_top }
  let(:stack_top_type) { 'sometype' }
  let(:stack_top_value) { 'somevalue' }

  let(:gets_value) { "I CAN HAS CHEESEBURGER?\n" }

  let(:instruction_argument_count) { Chameleon::VM.instruction_argument_count(opcode) }

  let(:instruction_execution) { -> { Chameleon::VM.execute_instruction!(opcode, [], engine) } }
end
