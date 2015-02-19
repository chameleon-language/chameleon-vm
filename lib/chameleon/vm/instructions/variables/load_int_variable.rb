Chameleon::VM.register_instruction Chameleon::VM::I_LOAD_INT_VAR, 1,
  (lambda do |args, engine|
    index = args.first

    unless index.is_a?(Integer) && index >= 0
      fail Chameleon::VM::InvalidArgumentError,
           %(ERROR while trying to STORE_INT_VAR with index '#{index.inspect}',
             type is not valid index (natural))
    end

    var = engine.fetch_variable(index)

    unless var.respond_to?(:type) && var.type == Chameleon::VM::T_INT
      fail Chameleon::VM::InvalidVariableTypeError,
           %(ERROR while trying to LOAD_INT_VAR #{var.inspect},
             type is not int (#{Chameleon::VM::T_INT}))
    end

    engine.push_to_stack! var
  end)
