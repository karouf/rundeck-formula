require 'spec_helper'

describe package('rundeck') do
  it { should be_installed }
end

describe service('rundeckd') do
  it { should be_enabled }
  it { should be_running }
end
