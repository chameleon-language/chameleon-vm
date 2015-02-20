Chameleon::VM.register_instruction Chameleon::VM::I_LOAD_INT_VAR, 1,
  (lambda do |args, engine|
    index = args.first

    Chameleon::VM::Validator.perform_index_check! index, 'LOAD_INT_VAR'

    var = engine.fetch_variable(index)

    Chameleon::VM::Validator.perform_variable_type_check! var,
                                                          Chameleon::VM::T_INT,
                                                          'LOAD_INT_VAR'

    engine.push_to_stack var
  end)
