Chameleon::VM.register_instruction Chameleon::VM::I_MULTIPLY, 0,
  (lambda do |_args, engine|
    unless engine.top_of_stack(2).all? { |c| c.type == Chameleon::VM::T_INT }
      fail Chameleon::VM::CorruptedStackError,
           %(ERROR while trying to MULTIPLY #{engine.top_of_stack(2)},
             type is not int (#{Chameleon::VM::T_INT}))
    end

    engine.push_to_stack! OpenStruct.new(type: Chameleon::VM::T_INT,
                                         value: (engine.pop_from_stack!.value *
                                                 engine.pop_from_stack!.value))
  end)
