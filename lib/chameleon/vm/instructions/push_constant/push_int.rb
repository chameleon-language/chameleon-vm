Chameleon::VM.register_instruction Chameleon::VM::I_PUSH_INT, 1,
  (lambda do |args, engine|
    const = args.first
    unless const.is_a? Integer
      fail Chameleon::VM::InvalidArgumentError,
           %(ERROR while trying to PUSH_INT '#{const.inspect}',
             type is not int)
    end
    engine.push_to_stack! OpenStruct.new(type: Chameleon::VM::T_INT,
                                         value: const)
  end)
