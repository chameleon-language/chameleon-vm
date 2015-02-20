Chameleon::VM.register_instruction Chameleon::VM::I_PUSH_INT, 1,
  (lambda do |args, engine|
    const = args.first

    Chameleon::VM::Validator.perform_type_check! const, Integer, 'PUSH_INT'

    engine.push_to_stack OpenStruct.new(type: Chameleon::VM::T_INT,
                                        value: const)
  end)
