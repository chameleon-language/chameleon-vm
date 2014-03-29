require 'spec_helper'

describe 'input-output instructions' do

  include_context "instruction related"

  describe 'PUTS' do
    let(:opcode) { Chameleon::VM::I_PUTS }

    it 'has zero arguments' do
      expect(instruction_argument_count).to eq(0)
    end

    context 'when there is a string on the top of the stack' do
      let(:stack_top_type)  { Chameleon::VM::T_STRING }
      let(:stack_top_value) { "O HAI" }

      it 'it removes it from the stack and prints it\'s value' do
        expect(engine).to receive(:pop_from_stack!)
        expect(engine.output).to receive(:puts) do |to_put|
          expect(to_put).to eq(stack_top_value)
        end

        instruction_execution.call
      end
    end

    context 'when there is something other than a string on the top of the stack' do
      let(:stack_top_type) { 'notastring' }

      it 'it throws an exception and leaves the stack be' do
        expect {
          expect(engine).not_to receive(:pop_from_stack!)
          instruction_execution.call
        }.to raise_exception(Chameleon::VM::CorruptedStackError, /not string/)
      end
    end

  end

  describe 'GETS' do
    let(:opcode) { Chameleon::VM::I_GETS }

    it 'has zero arguments' do
      expect(instruction_argument_count).to eq(0)
    end

    it 'gets a string from the input and pushes it (without trailing ws) to the stack' do
      expect(engine.input).to receive(:gets)

      expect(engine).to receive(:push_to_stack!) do |cell|
        expect(cell.type).to eq(Chameleon::VM::T_STRING)
        expect(cell.value).to eq(gets_value.strip)
      end

      instruction_execution.call
    end

  end
end
