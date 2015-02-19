Chameleon::VM.register_instruction Chameleon::VM::I_STORE_INT_VAR, 1,
  (lambda do |args, engine|
    index = args.first

    unless index.is_a?(Integer) && index >= 0
      fail Chameleon::VM::InvalidArgumentError,
           %(ERROR while trying to STORE_INT_VAR with index '#{index.inspect}',
             type is not valid index (natural))
    end

    unless engine.top_of_stack.type == Chameleon::VM::T_INT
      fail Chameleon::VM::InvalidArgumentError,
           %(ERROR while trying to STORE_INT_VAR '#{engine.top_of_stack.inspect}',
             type is not int)
    end

    engine.assign_variable! index, engine.pop_from_stack!
  end)
