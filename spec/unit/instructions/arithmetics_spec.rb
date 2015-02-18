require 'spec_helper'

describe 'arithmetics instructions' do
  include_context 'instruction related'

  describe 'ADD' do
    let(:opcode) { Chameleon::VM::I_ADD }

    it 'has zero arguments' do
      expect(instruction_argument_count).to eq(0)
    end

    let(:stack_top) { [tos, tos2] }
    before { allow(engine).to receive(:pop_from_stack!).and_return(tos, tos2) }
    let(:tos) { double 'cell', type: Chameleon::VM::T_INT, value: 13 }
    let(:tos2) { double 'cell', type: Chameleon::VM::T_INT, value: 29 }

    context 'when there are two integers on the top of the stack' do
      it 'it removes the top two stack elements and puts back their sum' do
        expect(engine).to receive(:pop_from_stack!).twice

        expect(engine).to receive(:push_to_stack!) do |cell|
          expect(cell.type).to eq(Chameleon::VM::T_INT)
          expect(cell.value).to eq(tos.value + tos2.value)
        end

        instruction_execution.call
      end
    end

    context 'when there are anything other
            than two integers on the top of the stack' do
      let(:tos) { double 'cell', type: Chameleon::VM::T_STRING, value: '42' }

      it 'it throws an exception and leaves the stack be' do
        expect do
          expect(engine).not_to receive(:pop_from_stack!)
          instruction_execution.call
        end.to raise_exception(Chameleon::VM::CorruptedStackError, /not int/)
      end
    end
  end

  describe 'MULTIPLY' do
    let(:opcode) { Chameleon::VM::I_MULTIPLY }

    it 'has zero arguments' do
      expect(instruction_argument_count).to eq(0)
    end

    let(:stack_top) { [tos, tos2] }
    before { allow(engine).to receive(:pop_from_stack!).and_return(tos, tos2) }
    let(:tos) { double 'cell', type: Chameleon::VM::T_INT, value: 13 }
    let(:tos2) { double 'cell', type: Chameleon::VM::T_INT, value: 29 }

    context 'when there are two integers on the top of the stack' do
      it 'it removes the top two stack elements and puts back their product' do
        expect(engine).to receive(:pop_from_stack!).twice

        expect(engine).to receive(:push_to_stack!) do |cell|
          expect(cell.type).to eq(Chameleon::VM::T_INT)
          expect(cell.value).to eq(tos.value * tos2.value)
        end

        instruction_execution.call
      end
    end

    context 'when there are anything other
            than two integers on the top of the stack' do
      let(:tos) { double 'cell', type: Chameleon::VM::T_STRING, value: '42' }

      it 'it throws an exception and leaves the stack be' do
        expect do
          expect(engine).not_to receive(:pop_from_stack!)
          instruction_execution.call
        end.to raise_exception(Chameleon::VM::CorruptedStackError, /not int/)
      end
    end
  end
end
