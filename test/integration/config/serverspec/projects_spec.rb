require 'spec_helper'

describe file('/etc/rundeck/rundeck-config.properties') do
  its(:content) { should match /rundeck.projectsStorageType = db/ }
end

describe file('/etc/rundeck/project.properties') do
  its(:content) { should match /project.dir = \/home\/rundeck\/projects\/\$\{project\.name\}/ }
  its(:content) { should match /project.etc.dir = \/home\/rundeck\/projects\/\$\{project\.name\}\/etc/ }
  its(:content) { should match /project.resources.file = \/home\/rundeck\/projects\/\$\{project\.name\}\/etc\/resources\.yml/ }
end
