require 'stringio'
require 'spec_helper'

describe Chameleon::VM::Engine do

  it { expect(subject).to respond_to(:run!).with(1).argument }

end
