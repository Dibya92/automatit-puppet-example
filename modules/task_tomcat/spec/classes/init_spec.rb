require 'spec_helper'
describe 'task_tomcat' do
  context 'with default values for all parameters' do
    it { should contain_class('task_tomcat') }
  end
end
