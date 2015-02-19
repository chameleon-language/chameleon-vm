require 'spec_helper'

describe 'variable related instructions' do
  include_context 'instruction related'

  let(:instruction_arguments) { [index] }

  describe 'STORE_INT_VAR' do
    let(:opcode) { Chameleon::VM::I_STORE_INT_VAR }

    it 'has one argument' do
      expect(instruction_argument_count).to eq(1)
    end

    context 'when given correct arguments' do
      let(:index) { 3 }
      let(:stack_top_type) { Chameleon::VM::T_INT }
      let(:stack_top_value) { 42 }

      it 'it stores the variable' do
        expect(engine).to receive(:assign_variable!) do |i, cell|
          expect(i).to eq index
          expect(cell).to eq(stack_top)
        end

        instruction_execution.call
      end
    end

    context 'when given an invalid index' do
      let(:index) { -3 }

      it 'it throws an exception and leaves the variables be' do
        expect do
          expect(engine).not_to receive(:assign_variable!)
          instruction_execution.call
        end.to raise_exception(Chameleon::VM::InvalidArgumentError, /not valid index/)
      end
    end

    context 'when given an invalid value' do
      let(:index) { 3 }
      let(:stack_top_type) { Chameleon::VM::T_STRING }
      let(:stack_top_value) { '42' }

      it 'it throws an exception and leaves the variables be' do
        expect do
          expect(engine).not_to receive(:assign_variable!)
          instruction_execution.call
        end.to raise_exception(Chameleon::VM::InvalidArgumentError, /not int/)
      end
    end
  end

  describe 'LOAD_INT_VAR' do
    let(:opcode) { Chameleon::VM::I_LOAD_INT_VAR }

    it 'has one argument' do
      expect(instruction_argument_count).to eq(1)
    end

    context 'when given a correct index that holds an integer variable' do
      let(:index) { 3 }
      let(:value) { 42 }
      let(:cell) { double 'cell', type: Chameleon::VM::T_INT, value: value }

      it 'it pushes the variable to the top of the stack' do
        expect(engine).to receive(:fetch_variable).with(index).at_least(:once).and_return(cell)

        expect(engine).to receive(:push_to_stack!) do |c|
          expect(c).to eq engine.fetch_variable(index)
        end

        instruction_execution.call
      end
    end

    context 'when given an invalid index' do
      let(:index) { -3 }
      let(:value) { 42 }

      it 'it throws an exception and leaves the stack be' do
        expect do
          expect(engine).not_to receive(:fetch_variable)
          expect(engine).not_to receive(:push_to_stack!)
          instruction_execution.call
        end.to raise_exception(Chameleon::VM::InvalidArgumentError, /not valid index/)
      end
    end

    context 'when given a correct index that holds a non-integer variable' do
      let(:index) { 3 }
      let(:value) { '42' }

      it 'it throws an exception and leaves the stack be' do
        expect do
          expect(engine).to receive(:fetch_variable)
          expect(engine).not_to receive(:push_to_stack!)

          instruction_execution.call
        end.to raise_exception(Chameleon::VM::InvalidVariableTypeError, /not int/)
      end
    end
  end
end
