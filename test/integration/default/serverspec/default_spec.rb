require 'spec_helper'

describe package('rundeck') do
  it { should be_installed }
end
