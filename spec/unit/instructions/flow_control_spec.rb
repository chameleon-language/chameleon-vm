require 'spec_helper'

describe 'flow control related instructions' do
  include_context 'instruction related'

  let(:instruction_arguments) { [line] }
  let(:line) { 4 }

  describe 'GOTO' do
    let(:opcode) { Chameleon::VM::I_GOTO }

    it 'has one argument' do
      expect(instruction_argument_count).to eq(1)
    end

    context 'when given a correct argument' do
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

  describe 'GOTO_IF_LESS' do
    let(:opcode) { Chameleon::VM::I_GOTO_IF_LESS }
    before { allow(engine).to receive(:top_of_stack).and_return(stack_top) }
    before { allow(engine).to receive(:pop_from_stack).and_return(stack_top) }
    let(:stack_top) { [tos2, tos] }
    let(:tos) { double 'cell', type: Chameleon::VM::T_INT, value: 13 }
    let(:tos2) { double 'cell', type: Chameleon::VM::T_INT, value: 29 }

    it 'has one argument' do
      expect(instruction_argument_count).to eq(1)
    end

    context 'when there are two integers on the top of the stack' do
      context 'when the condition is true' do
        it 'it executes the goto' do
          expect(engine).to receive(:pop_from_stack).with(2)

          expect(engine).to receive(:goto) do |line|
            expect(line).to eq(line)
          end

          instruction_execution.call
        end
      end

      context 'when the condition is false' do
        let(:tos2) { double 'cell', type: Chameleon::VM::T_INT, value: 13 }
        let(:tos) { double 'cell', type: Chameleon::VM::T_INT, value: 29 }

        it 'it executes the goto' do
          expect(engine).to receive(:pop_from_stack).with(2)

          expect(engine).not_to receive(:goto)

          instruction_execution.call
        end
      end
    end

    context 'when there are anything other
            than two integers on the top of the stack' do
      let(:tos) { double 'cell', type: Chameleon::VM::T_STRING, value: '29' }
      let(:tos2) { nil }

      it 'it throws an exception and leaves the stack be' do
        expect do
          expect(engine).not_to receive(:pop_from_stack)
          expect(engine).not_to receive(:goto)
          instruction_execution.call
        end.to raise_exception(Chameleon::VM::CorruptedStackError)
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
