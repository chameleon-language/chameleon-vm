require 'stringio'
require 'spec_helper'

describe Chameleon::VM::Engine do
  it 'can run a bytecode sequence' do
    expect(subject).to respond_to(:run!)
  end

  context 'default input' do
    it 'is the standard input' do
      expect(subject.input).to equal(STDIN)
    end
  end

  context 'default output' do
    it 'is the standard output' do
      expect(subject.output).to equal(STDOUT)
    end
  end

  context 'input as a parameter' do
    let(:input) { StringIO.new }
    subject { Chameleon::VM::Engine.new input:  input }

    it 'is the given parameter' do
      expect(subject.input).to equal(input)
    end
  end

  context 'output as a parameter' do
    let(:output) { StringIO.new }
    subject { Chameleon::VM::Engine.new output: output }

    it 'is the given parameter' do
      expect(subject.output).to equal(output)
    end
  end

  describe 'interface' do
    let(:cell1) { double 'cell', type: 'sometype1', value: 'somevalue1' }
    let(:cell2) { double 'cell', type: 'sometype2', value: 'somevalue2' }
    let(:cell3) { double 'cell', type: 'sometype3', value: 'somevalue3' }

    describe '#goto!' do
      let(:index) { 12 }

      it 'moves the stack pointer' do
        expect(subject.stack_pointer).to eq(0)
        subject.goto! index
        expect(subject.stack_pointer).to eq(index)
      end
    end

    describe '#assign_variable! & #fetch_variable' do
      let(:index) { 2 }

      it 'assigns/fetches variable by index' do
        expect(subject.fetch_variable(index)).to be_nil
        subject.assign_variable! index, cell1
        expect(subject.fetch_variable(index)).to eq(cell1)
      end
    end

    describe '#push_to_stack!' do
      it 'pushes the item to the top of the stack
         and increments the stack pointer' do
        subject.push_to_stack! cell1
        expect(subject.top_of_stack).to eq(cell1)
        expect(subject.stack_pointer).to eq(1)

        subject.push_to_stack! cell2
        expect(subject.top_of_stack(2)).to eq([cell2, cell1])
        expect(subject.stack_pointer).to eq(2)

        subject.push_to_stack! cell3
        expect(subject.top_of_stack(3)).to eq([cell3, cell2, cell1])
        expect(subject.stack_pointer).to eq(3)
      end
    end

    describe '#pop_from_stack!' do
      context 'when there is at least one item in the stack' do
        it 'removes the item from the stack and returns it' do
          subject.push_to_stack! cell1
          subject.push_to_stack! cell3

          item = subject.pop_from_stack!
          expect(item).to eq(cell3)
          expect(subject.stack_pointer).to eq(1)
        end
      end

      context 'when the stack is empty' do
        it 'it throws an exception' do
          expect do
            subject.pop_from_stack!
          end.to raise_exception(Chameleon::VM::StackUnderflowError)
        end
      end
    end

    describe '#top_of_stack' do
      let(:vm_with_stack) do
        subject.push_to_stack! cell1
        subject.push_to_stack! cell2
        subject.push_to_stack! cell3

        subject
      end

      context 'when looking for only one item' do
        it 'returns the top item (and doesn\'t change the stack_pointer)' do
          expect(vm_with_stack.top_of_stack).to eq(cell3)
          expect(vm_with_stack.stack_pointer).to eq(3)
        end
      end

      context 'when looking for more items' do
        context 'when the stack has at least
                as many items as we are looking for' do
          it 'returns the top items as an array
             (and doesn\'t change the stack_pointer)' do
            expect(vm_with_stack.top_of_stack(2)).to eq([cell3, cell2])
            expect(vm_with_stack.stack_pointer).to eq(3)

            expect(vm_with_stack.top_of_stack(3)).to eq([cell3, cell2, cell1])
            expect(vm_with_stack.stack_pointer).to eq(3)
          end
        end

        context 'when the stack does\'nt have
                at least as many item as we are looking for' do
          it 'it throws an exception' do
            expect do
              subject.top_of_stack(4)
            end.to raise_exception(Chameleon::VM::StackUnderflowError)
          end
        end
      end
    end

    describe '#run!' do
      context 'running an instruction without arguments' do
        let(:instructions) { [Chameleon::VM::I_TOS] }
        let(:cell) { double 'cell', type: Chameleon::VM::T_INT, value: 42 }

        it 'it calls the right instruction' do
          subject.push_to_stack! cell

          expect(Chameleon::VM).to receive(:execute_instruction!)
            .with(Chameleon::VM::I_TOS, [], subject)

          subject.run! instructions
        end
      end
    end
  end
end
