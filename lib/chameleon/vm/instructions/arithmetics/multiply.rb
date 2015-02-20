Chameleon::VM.register_instruction Chameleon::VM::I_MULTIPLY, 0,
  (lambda do |_args, engine|
    Chameleon::VM::Validator.perform_multiple_tos_type_check! engine,
                                                              2,
                                                              Chameleon::VM::T_INT,
                                                              'MULTIPLY'

    engine.push_to_stack OpenStruct.new(type: Chameleon::VM::T_INT,
                                        value: (engine.pop_from_stack.value *
                                                engine.pop_from_stack.value))
  end)
