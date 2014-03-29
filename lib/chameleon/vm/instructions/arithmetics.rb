Chameleon::VM.register_instruction Chameleon::VM::I_ADD, 0, ->(args, engine) do
  unless engine.top_of_stack(2).all?{ |cell| cell.type == Chameleon::VM::T_INT}
    raise Chameleon::VM::CorruptedStackError,
          %{ERROR while trying to ADD #{engine.top_of_stack(2)},
            type is not int (#{Chameleon::VM::T_INT})}
  end

  engine.push_to_stack! OpenStruct.new(type: Chameleon::VM::T_INT,
                                       value: (engine.pop_from_stack!.value +
                                               engine.pop_from_stack!.value))
end
