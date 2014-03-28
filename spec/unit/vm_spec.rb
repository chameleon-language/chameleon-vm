require 'spec_helper'

describe Chameleon::VM do

  it 'has a version' do
    expect(subject).to have_constant(:VERSION)
  end

  [:I_GETS, :I_PUTS, :I_ADD, :I_TOI].each do |instruction|
    it "has a(n) #{instruction[2..-1]} instruction" do
      expect(subject).to have_constant(instruction)
    end
  end

end
