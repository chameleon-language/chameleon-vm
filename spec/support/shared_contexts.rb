shared_context 'instruction related' do
  let(:engine) do
    double 'engine',
           push_to_stack!: stack_top,
           top_of_stack: stack_top,
           pop_from_stack!: stack_pop,
           output: double('output').as_null_object,
           input: double('input', gets: gets_value)
  end

  let(:stack_top) do
    double 'cell', type: stack_top_type, value: stack_top_value
  end
  let(:stack_pop) { stack_top }
  let(:stack_top_type) { 'sometype' }
  let(:stack_top_value) { 'somevalue' }

  let(:gets_value) { "I CAN HAS CHEESEBURGER?\n" }

  let(:instruction_argument_count) do
    Chameleon::VM.instruction_argument_count(opcode)
  end

  let(:instruction_execution) do
    -> { Chameleon::VM.execute_instruction!(opcode, [], engine) }
  end
end
