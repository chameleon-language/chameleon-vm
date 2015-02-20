Chameleon::VM.register_instruction Chameleon::VM::I_PUTS, 0,
  (lambda do |_args, engine|
    Chameleon::VM::Validator.perform_tos_type_check! engine,
                                                     Chameleon::VM::T_STRING,
                                                     'PUTS'

    engine.output.puts engine.pop_from_stack.value
  end)
