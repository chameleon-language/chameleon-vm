require 'spec_helper'

describe 'push constant instructions' do
  include_context 'instruction related'

  describe 'PUSH_INT' do
    let(:opcode) { Chameleon::VM::I_PUSH_INT }

    it 'has one argument' do
      expect(instruction_argument_count).to eq(1)
    end

    context 'when given an integer argument' do
      let(:int_const) { 42 }
      let(:instruction_arguments) { [int_const] }

      it 'it pushes the given integer value to the stack' do
        expect(engine).to receive(:push_to_stack!) do |cell|
          expect(cell.type).to eq(Chameleon::VM::T_INT)
          expect(cell.value).to eq(int_const)
        end

        instruction_execution.call
      end
    end

    context 'when given a non-integer argument' do
      let(:non_int_const) { '42' }
      let(:instruction_arguments) { [non_int_const] }

      it 'it throws an exception and leaves the stack be' do
        expect do
          expect(engine).not_to receive(:push_to_stack!)
          instruction_execution.call
        end.to raise_exception(Chameleon::VM::InvalidArgumentError, /not int/)
      end
    end
  end
end
