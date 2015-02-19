Chameleon::VM.register_instruction Chameleon::VM::I_INCR_INT_VAR, 2,
  (lambda do |args, engine|
    index, inc = args

    Chameleon::VM::Validator.perform_index_check! index, 'INCR_INT_VAR'
    Chameleon::VM::Validator.perform_type_check! inc, Integer, 'INCR_INT_VAR'

    var = engine.fetch_variable(index)

    Chameleon::VM::Validator.perform_variable_type_check! var,
                                                          Chameleon::VM::T_INT,
                                                          'INCR_INT_VAR'

    engine.assign_variable! index, OpenStruct.new(type: Chameleon::VM::T_INT,
                                                  value: (var.value + inc))
  end)
