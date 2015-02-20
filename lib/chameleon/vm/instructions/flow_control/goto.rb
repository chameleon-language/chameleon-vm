Chameleon::VM.register_instruction Chameleon::VM::I_GOTO, 1,
  (lambda do |args, engine|
    line = args.first

    Chameleon::VM::Validator.perform_type_check! line, Integer, 'GOTO'

    engine.goto line
  end)
