require 'spec_helper'

describe 'type cast instructions' do
  include_context 'instruction related'

  describe 'TOI' do
    let(:opcode) { Chameleon::VM::I_TOI }

    it 'has zero arguments' do
      expect(instruction_argument_count).to eq(0)
    end

    let(:stack_top_type)  { Chameleon::VM::T_STRING }
    let(:stack_top_value) { '22' }

    it 'it converts the the value at the stack\'s top to integer' do
      expect(engine).to receive(:pop_from_stack)

      expect(engine).to receive(:push_to_stack) do |cell|
        expect(cell.type).to eq(Chameleon::VM::T_INT)
        expect(cell.value).to eq(stack_top_value.to_i)
      end

      instruction_execution.call
    end
  end

  describe 'TOS' do
    let(:opcode) { Chameleon::VM::I_TOS }

    it 'has zero arguments' do
      expect(instruction_argument_count).to eq(0)
    end

    let(:stack_top_type)  { Chameleon::VM::T_INT }
    let(:stack_top_value) { 22 }

    it 'it converts the the value at the stack\'s top to string' do
      expect(engine).to receive(:pop_from_stack)

      expect(engine).to receive(:push_to_stack) do |cell|
        expect(cell.type).to eq(Chameleon::VM::T_STRING)
        expect(cell.value).to eq(stack_top_value.to_s)
      end

      instruction_execution.call
    end
  end
end
