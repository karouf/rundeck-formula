require 'spec_helper'

describe command('rd-jobs list -p my-project') do
  its(:stdout) { should contain '2 jobs' }
  its(:stdout) { should contain '- simple-job' }
  its(:stdout) { should contain '- nested/job' }
end
