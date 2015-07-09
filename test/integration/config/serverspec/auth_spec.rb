require 'spec_helper'

describe file('/etc/rundeck/realm.properties') do
  its(:content) { should match /^admin:admin,user,admin$/ }
  its(:content) { should match /^user:passwd,user$/ }
end
