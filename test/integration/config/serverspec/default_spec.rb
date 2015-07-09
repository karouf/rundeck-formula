require 'spec_helper'

describe file('/etc/rundeck/rundeck-config.properties') do
  its(:content) { should match /^grails.serverURL = http:\/\/rundeck.local:80$/ }
end
