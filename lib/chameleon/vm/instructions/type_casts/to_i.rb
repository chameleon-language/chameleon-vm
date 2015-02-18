Chameleon::VM.register_instruction Chameleon::VM::I_TOI, 0,
  (lambda do |_args, engine|
    engine.push_to_stack! OpenStruct.new(type: Chameleon::VM::T_INT,
                                         value: engine.pop_from_stack!.value.to_i)
  end)
