Chameleon::VM.register_instruction Chameleon::VM::I_TOS, 0,
  (lambda do |_args, engine|
    engine.push_to_stack OpenStruct.new(type: Chameleon::VM::T_STRING,
                                        value: engine.pop_from_stack.value.to_s)
  end)
