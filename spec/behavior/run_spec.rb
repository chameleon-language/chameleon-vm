require 'stringio'
require 'spec_helper'

describe 'running bytecode' do
  let(:output) { StringIO.new }

  let(:vm) { Chameleon::VM::Engine.new(input: input, output: output) }

  let(:gets) { Chameleon::VM::I_GETS }
  let(:puts) { Chameleon::VM::I_PUTS }
  let(:toi)  { Chameleon::VM::I_TOI  }
  let(:tos)  { Chameleon::VM::I_TOS  }

  let(:int1) { 2 }
  let(:int2) { 40 }

  describe 'arithmetics' do
    let(:add)  { Chameleon::VM::I_ADD  }
    let(:multiply) { Chameleon::VM::I_MULTIPLY }

    let(:input) do
      input = StringIO.new
      input.puts int1
      input.puts int2
      input.rewind

      input
    end

    describe 'iteration 01' do
      let(:sum)  { int1 + int2 }

      let(:bytecode) { [gets, toi, gets, toi, add, tos, puts] }

      it 'it can read two integers from the command line and output their sum' do
        vm.run! bytecode
        expect(vm.output.string.to_i).to eq(sum)
      end
    end

    describe 'iteration 02' do
      let(:product)  { int1 * int2 }

      let(:bytecode) { [gets, toi, gets, toi, multiply, tos, puts] }

      it 'it can read two integers from the command line and output their product' do
        vm.run! bytecode
        expect(vm.output.string.to_i).to eq(product)
      end
    end
  end
end
