require 'spec_helper'

describe file('/var/rundeck/projects/directory/etc/project.properties') do
  it { should be_file }
  its(:content) { should match /resources\.source\.1\.type = directory/ }
  its(:content) { should match /resources\.source\.1\.config\.directory = \/var\/rundeck\/projects\/\$\{project\.name\}\/etc\/resources/ }
end
