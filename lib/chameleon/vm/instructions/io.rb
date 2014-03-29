Chameleon::VM.register_instruction Chameleon::VM::I_PUTS, 0, ->(args, engine) do
  unless engine.top_of_stack.type == Chameleon::VM::T_STRING
    raise Chameleon::VM::CorruptedStackError,
          %{ERROR while trying to PUTS #{engine.top_of_stack},
            type is not string (#{Chameleon::VM::T_STRING})}
  end

  engine.output.puts engine.pop_from_stack!.value
end

Chameleon::VM.register_instruction Chameleon::VM::I_GETS, 0, ->(args, engine) do
  engine.push_to_stack! OpenStruct.new(type: Chameleon::VM::T_STRING,
                                       value: engine.input.gets.strip)
end