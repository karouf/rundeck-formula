require 'spec_helper'

describe file('/var/rundeck/projects/default') do
  it { should be_directory }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 755 }
end

describe file('/var/rundeck/projects/default/etc') do
  it { should be_directory }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 755 }
end

describe file('/var/rundeck/projects/default/etc/project.properties') do
  it { should be_file }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 664 }
  its(:content) { should match /project\.name = default/ }
  its(:content) { should match /service\.NodeExecutor\.default\.provider = jsch-ssh/ }
  its(:content) { should match /project\.ssh-authentication = privateKey/ }
  its(:content) { should match /project\.ssh-keypath = \/var\/lib\/rundeck\/\.ssh\/id_rsa/ }
  its(:content) { should match /service\.FileCopier\.default\.provider = jsch-scp/ }
  its(:content) { should match /resources\.source\.1\.type = file/ }
  its(:content) { should match /resources\.source\.1\.config\.format = resourcexml/ }
  its(:content) { should match /resources\.source\.1\.config\.file = \/var\/rundeck\/projects\/\$\{project\.name\}\/etc\/resources\.xml/ }
  its(:content) { should match /resources\.source\.1\.config\.generateFileAutomatically = true/ }
  its(:content) { should match /resources\.source\.1\.config\.includeServerNode = true/ }
  its(:content) { should match /resources\.source\.1\.config\.requireFileExists = false/ }
end

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

describe file('/var/rundeck/projects/stub/etc/project.properties') do
  it { should be_file }
  its(:content) { should match /resources\.source\.1\.type = stub/ }
  its(:content) { should match /resources\.source\.1\.config\.prefix = node/ }
  its(:content) { should match /resources\.source\.1\.config\.count = 1/ }
  its(:content) { should match /resources\.source\.1\.config\.tags = stub/ }
  its(:content) { should match /resources\.source\.2\.type = stub/ }
  its(:content) { should match /resources\.source\.2\.config\.prefix = fake/ }
  its(:content) { should match /resources\.source\.2\.config\.suffix = really/ }
  its(:content) { should match /resources\.source\.2\.config\.count = 2/ }
  its(:content) { should match /resources\.source\.2\.config\.tags = fake/ }
end

describe file('/var/rundeck/projects/pillar/etc/project.properties') do
  it { should be_file }
  its(:content) { should match /resources\.source\.1\.type = file/ }
  its(:content) { should match /resources\.source\.1\.config\.format = resourceyaml/ }
  its(:content) { should match /resources\.source\.1\.config\.file = \/var\/rundeck\/projects\/\$\{project\.name\}\/etc\/resources\.yaml/ }
  its(:content) { should match /resources\.source\.1\.config\.includeServerNode = true/ }
  its(:content) { should match /resources\.source\.1\.config\.generateFileAutomatically = true/ }
  its(:content) { should match /resources\.source\.1\.config\.requireFileExists = true/ }
end

describe file('/var/rundeck/projects/pillar/etc/resources.yaml') do
  it { should be_file }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 664 }
  its(:content) { should match /rundeck-server:/ }
  its(:content) { should match /hostname: 127\.0\.0\.1/ }
  its(:content) { should match /username: rundeck/ }
  its(:content) { should match /another-server:/ }
  its(:content) { should match /hostname: 127\.0\.0\.2/ }
  its(:content) { should match /username: admin/ }
  its(:content) { should match /description: Another server/ }
  its(:content) { should match /tags: server,test/ }
  its(:content) { should match /osFamily: unix/ }
  its(:content) { should match /osArch: amd64/ }
  its(:content) { should match /osName: Linux/ }
  its(:content) { should match /osVersion: 3.16.0-0.bpo.4-amd64/ }
  its(:content) { should match /custom: attribute/ }
  its(:content) { should match /server-with-tags-list:/ }
  its(:content) { should match /hostname: 127\.0\.0\.3/ }
  its(:content) { should match /username: user/ }
  its(:content) { should match /tags: dev,proto/ }
end
