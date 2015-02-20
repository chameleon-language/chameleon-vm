require 'stringio'
require 'spec_helper'

describe 'running bytecode' do
  let(:output) { StringIO.new }

  let(:vm) { Chameleon::VM::Engine.new(input: input, output: output) }

  let(:i_gets) { Chameleon::VM::I_GETS }
  let(:i_puts) { Chameleon::VM::I_PUTS }
  let(:toi)  { Chameleon::VM::I_TOI  }
  let(:tos)  { Chameleon::VM::I_TOS  }

  let(:int1) { 2 }
  let(:int2) { 40 }

  let(:input) { StringIO.new }

  describe 'iteration 01 & 02' do
    let(:add)  { Chameleon::VM::I_ADD  }
    let(:multiply) { Chameleon::VM::I_MULTIPLY }

    let(:input) do
      input = StringIO.new
      input.puts int1
      input.puts int2
      input.rewind

      input
    end

    describe 'add' do
      let(:sum)  { int1 + int2 }

      let(:bytecode) { [i_gets, toi, i_gets, toi, add, tos, i_puts] }

      it 'can read two integers from the command line and output their sum' do
        vm.run bytecode
        expect(vm.output.string.to_i).to eq(sum)
      end
    end

    describe 'multiply' do
      let(:product)  { int1 * int2 }

      let(:bytecode) { [i_gets, toi, i_gets, toi, multiply, tos, i_puts] }

      it 'can read two integers from the command line and output their product' do
        vm.run bytecode
        expect(vm.output.string.to_i).to eq(product)
      end
    end
  end

  describe 'iteration 03' do
    let(:push_int) { Chameleon::VM::I_PUSH_INT }
    let(:push_string) { Chameleon::VM::I_PUSH_STRING }
    let(:store_int_var) { Chameleon::VM::I_STORE_INT_VAR }
    let(:load_int_var) { Chameleon::VM::I_LOAD_INT_VAR }
    let(:incr_int_var) { Chameleon::VM::I_INCR_INT_VAR }
    let(:goto) { Chameleon::VM::I_GOTO }
    let(:goto_if_less) { Chameleon::VM::I_GOTO_IF_LESS }

    context 'push int' do
      let(:bytecode) { [push_int, int1, tos, i_puts] }

      it 'can output an integer constant' do
        vm.run bytecode
        expect(vm.output.string.to_i).to eq(int1)
      end
    end

    context 'store & load variables' do
      let(:var_index) { 3 }

      let(:bytecode) do
        [push_int, int1, store_int_var, var_index, load_int_var, var_index, tos, i_puts]
      end

      it 'can store and load integer variables' do
        vm.run bytecode
        expect(vm.output.string.to_i).to eq(int1)
      end
    end

    context 'increment variables' do
      let(:var_index) { 3 }

      let(:bytecode) do
        [push_int, int1,
         store_int_var, var_index,
         incr_int_var, var_index, int2,
         load_int_var, var_index,
         tos, i_puts]
      end

      it 'can increment an integer variables' do
        vm.run bytecode
        expect(vm.output.string.to_i).to eq(int1 + int2)
      end
    end

    context 'full package' do
      let(:str) { 5 }
      let(:fin) { 0 }
      let(:var_index) { 2 }
      let(:blast_off) { 'Blast off!' }

      let(:bytecode) do
        [push_int, str,
         store_int_var, var_index,
         goto, 13,
         load_int_var, var_index,
         tos, i_puts,
         incr_int_var, var_index, -1,
         push_int, fin,
         load_int_var, var_index,
         goto_if_less, 6,
         push_string, blast_off, i_puts]
      end

      it 'can has blast off!' do
        vm.run bytecode
        expect(vm.output.string).to eq("#{str.downto(fin + 1).to_a.join("\n")}\n#{blast_off}\n")
      end
    end
  end
end
