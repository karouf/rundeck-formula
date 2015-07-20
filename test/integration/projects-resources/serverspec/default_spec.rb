require 'spec_helper'

describe file('/var/rundeck/projects/directory/etc/project.properties') do
  it { should be_file }
  its(:content) { should match /resources\.source\.1\.type = directory/ }
  its(:content) { should match /resources\.source\.1\.config\.directory = \/var\/rundeck\/projects\/\$\{project\.name\}\/etc\/resources/ }
end

describe file('/var/rundeck/projects/script/etc/project.properties') do
  it { should be_file }
  its(:content) { should match /resources\.source\.1\.type = script/ }
  its(:content) { should match /resources\.source\.1\.config\.format = resourcexml/ }
  its(:content) { should match /resources\.source\.1\.config\.file = \/usr\/bin\/rd-jobs/ }
  its(:content) { should_not match /resources\.source\.1\.config\.interpreter/ }
  its(:content) { should_not match /resources\.source\.1\.config\.args / }
  its(:content) { should match /resources\.source\.1\.config\.argsQuoted = false/ }
end

describe file('/var/rundeck/projects/script/etc/project.properties') do
  it { should be_file }
  its(:content) { should match /resources\.source\.2\.type = script/ }
  its(:content) { should match /resources\.source\.2\.config\.format = resourceyaml/ }
  its(:content) { should match /resources\.source\.2\.config\.file = \/usr\/bin\/rd-queue/ }
  its(:content) { should match /resources\.source\.2\.config\.interpreter = \/bin\/sh/ }
  its(:content) { should match /resources\.source\.2\.config\.args = nodes/ }
  its(:content) { should match /resources\.source\.2\.config\.argsQuoted = true/ }
end

describe file('/var/rundeck/projects/url/etc/project.properties') do
  it { should be_file }
  its(:content) { should match /resources\.source\.1\.type = url/ }
  its(:content) { should match /resources\.source\.1\.config\.url = http\\\:\/\/localhost\/nodes\.xml/ }
  its(:content) { should match /resources\.source\.1\.config\.timeout = 30/ }
  its(:content) { should match /resources\.source\.1\.config\.cache = true/ }
  its(:content) { should match /resources\.source\.2\.type = url/ }
  its(:content) { should match /resources\.source\.2\.config\.url = http\\\:\/\/localhost\/nodes2\.xml/ }
  its(:content) { should match /resources\.source\.2\.config\.timeout = 1800/ }
  its(:content) { should match /resources\.source\.2\.config\.cache = false/ }
end
