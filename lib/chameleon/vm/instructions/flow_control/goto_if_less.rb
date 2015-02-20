Chameleon::VM.register_instruction Chameleon::VM::I_GOTO_IF_LESS, 1,
  (lambda do |args, engine|
    line = args.first

    Chameleon::VM::Validator.perform_type_check! line, Integer, 'GOTO_IF_LESS'

    Chameleon::VM::Validator.perform_multiple_tos_type_check! engine,
                                                              2,
                                                              Chameleon::VM::T_INT,
                                                              'GOTO_IF_LESS'

    lhs, rhs = engine.pop_from_stack(2)
    engine.goto line if lhs.value > rhs.value
  end)
