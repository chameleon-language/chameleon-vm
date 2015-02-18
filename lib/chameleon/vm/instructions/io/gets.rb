Chameleon::VM.register_instruction Chameleon::VM::I_GETS, 0,
  (lambda do |_args, engine|
     engine.push_to_stack! OpenStruct.new(type: Chameleon::VM::T_STRING,
                                          value: engine.input.gets.strip)
   end)
