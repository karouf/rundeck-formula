require 'spec_helper'

describe package('rundeck') do
  it { should be_installed }
end

describe service('rundeckd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/rundeck/realm.properties') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its(:content) { should match /^admin:admin,user,admin$/ }
  its(:content) { should match /^user:passwd,user$/ }
end

describe file('/etc/rundeck/rundeck-config.properties') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its(:content) { should match /^grails.serverURL = http:\/\/rundeck.local:4440$/ }
  its(:content) { should match /^rundeck.projectsStorageType = filesystem$/ }
end

describe file('/etc/rundeck/project.properties') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  its(:content) { should match /^project.dir = \/var\/rundeck\/projects\/\$\{project\.name\}$/ }
  its(:content) { should match /^project.etc.dir = \/var\/rundeck\/projects\/\$\{project\.name\}\/etc$/ }
  its(:content) { should match /^project.resources.file = \/var\/rundeck\/projects\/\$\{project\.name\}\/etc\/resources\.xml$/ }
end
