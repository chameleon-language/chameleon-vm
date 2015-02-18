require 'spec_helper'

describe Chameleon::VM do
  it 'has a version' do
    expect(subject).to have_constant(:VERSION)
  end

  it 'has an instruction table' do
    expect(subject).to respond_to(:instruction).with(1).argument
  end

  it 'can register instructions' do
    expect(subject).to respond_to(:register_instruction).with(3).arguments
  end

  it 'can execute instructions' do
    expect(subject).to respond_to(:execute_instruction!).with(3).arguments
  end

  [:I_GETS, :I_PUTS, :I_ADD, :I_TOI, :I_TOS].each do |instruction|
    it "has a(n) #{instruction[2..-1]} instruction" do
      expect(subject).to have_constant(instruction)
      expect(subject.instruction(subject.const_get(instruction))).to be_lambda
    end
  end

  [:T_STRING, :T_INT].each do |type|
    it "has a(n) #{type[2..-1]} type" do
      expect(subject).to have_constant(type)
    end
  end
end
