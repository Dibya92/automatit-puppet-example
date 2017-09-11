require 'spec_helper'
describe 'task_apache' do
  context 'with default values for all parameters' do
    it { should contain_class('task_apache') }
  end
end
