require 'spec_helper'

describe 'Tassadar::VERSION' do
  it 'should be the correct version' do
    Tassadar::VERSION.should == '0.2.0'
  end
end