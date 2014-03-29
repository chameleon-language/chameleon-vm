Chameleon::VM.register_instruction Chameleon::VM::I_TOI, 0, ->(args, engine) do
  engine.push_to_stack! OpenStruct.new(type: Chameleon::VM::T_INT,
                                       value: engine.pop_from_stack!.value.to_i)
end

Chameleon::VM.register_instruction Chameleon::VM::I_TOS, 0, ->(args, engine) do
  engine.push_to_stack! OpenStruct.new(type: Chameleon::VM::T_STRING,
                                       value: engine.pop_from_stack!.value.to_s)
end
