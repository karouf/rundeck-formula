require 'spec_helper'

describe file('/var/rundeck/projects/my-project') do
  it { should be_directory }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 755 }
end

describe file('/var/rundeck/projects/my-project/etc') do
  it { should be_directory }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 755 }
end

describe file('/var/rundeck/projects/my-project/etc/project.properties') do
  it { should be_file }
  it { should be_owned_by 'rundeck' }
  it { should be_grouped_into 'rundeck' }
  it { should be_mode 664 }
  its(:content) { should match /project\.name = my-project/ }
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
