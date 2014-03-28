require 'stringio'
require 'spec_helper'

describe 'running bytecode' do
  let(:output) { StringIO.new }

  let(:vm) { Chameleon::VM::Engine.new(input: input, output: output) }

  describe 'iteration 01' do
    let(:gets) { Chameleon::VM::I_GETS }
    let(:puts) { Chameleon::VM::I_PUTS }
    let(:toi)  { Chameleon::VM::I_TOI  }
    let(:add)  { Chameleon::VM::I_ADD  }
    let(:int1) { 40 }
    let(:int2) { 2 }
    let(:sum)  { int1 + int2 }

    let(:input) do
      input = StringIO.new
      input.puts int1
      input.puts int2
      input.rewind

      input
    end

    let(:bytecode) { [gets, toi, gets, toi, add, puts] }

    it 'it can read two integers from the command line and output their sum' do
      vm.run! bytecode
      expect(vm.output.string).to eq(sum.to_s)
    end
  end

end
