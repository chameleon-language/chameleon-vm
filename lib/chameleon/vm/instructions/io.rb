Chameleon::VM.register_instruction Chameleon::VM::I_PUTS, ->(engine) do
  puts 'PUTS'
end

Chameleon::VM.register_instruction Chameleon::VM::I_GETS, ->(engine) do
  puts 'GETS'
end
