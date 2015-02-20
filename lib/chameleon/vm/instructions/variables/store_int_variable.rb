Chameleon::VM.register_instruction Chameleon::VM::I_STORE_INT_VAR, 1,
  (lambda do |args, engine|
    index = args.first

    Chameleon::VM::Validator.perform_index_check! index, 'STORE_INT_VAR'

    Chameleon::VM::Validator.perform_tos_type_check! engine,
                                                     Chameleon::VM::T_INT,
                                                     'STORE_INT_VAR'

    engine.assign_variable index, engine.pop_from_stack
  end)
