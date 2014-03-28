require 'stringio'
require 'spec_helper'

describe Chameleon::VM::Engine do

  it { expect(subject).to respond_to(:run!).with(1).argument }
  it { expect(subject).to respond_to(:input) }
  it { expect(subject).to respond_to(:output) }

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

end
