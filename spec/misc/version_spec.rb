require 'spec_helper'

describe 'version' do
  it 'it is has version number format' do
    expect(Chameleon::VM::VERSION).to match(/\d\.\d\.\d/)
  end
end
