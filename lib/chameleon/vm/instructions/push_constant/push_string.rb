Chameleon::VM.register_instruction Chameleon::VM::I_PUSH_STRING, 1,
  (lambda do |args, engine|
    const = args.first

    Chameleon::VM::Validator.perform_type_check! const, String, 'PUSH_STRING'

    engine.push_to_stack OpenStruct.new(type: Chameleon::VM::T_STRING,
                                        value: const)
  end)
