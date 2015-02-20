require 'spec_helper'

describe 'flow control related instructions' do
  include_context 'instruction related'

  describe 'GOTO' do
    let(:opcode) { Chameleon::VM::I_GOTO }
    let(:instruction_arguments) { [line] }

    it 'has one argument' do
      expect(instruction_argument_count).to eq(1)
    end

    context 'when given a correct argument' do
      let(:line) { 3 }

      it 'it moves the stack pointer to the specified line' do
        expect(engine).to receive(:goto) do |i|
          expect(i).to eq line
        end

        instruction_execution.call
      end
    end

    context 'when given a non-integer line' do
      let(:line) { '3' }

      it 'it throws an exception and leaves the stack pointer be' do
        expect do
          expect(engine).not_to receive(:goto)
          instruction_execution.call
        end.to raise_exception(Chameleon::VM::InvalidArgumentError)
      end
    end
  end
end
