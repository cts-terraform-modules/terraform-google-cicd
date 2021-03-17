# Load remaining variables
require 'yaml'
vars = YAML.load(File.read("test/variables/#{input('input_env_name')}.json"))

control 'gcp' do
  describe google_project(project: input('output_project')[:project_id]) do
    it { should exist }
    its('name') { should cmp "#{vars['prefix']}-#{vars['env_name']}-#{vars['purpose']}" }
    its('lifecycle_state') { should cmp 'ACTIVE' }
  end

  vars["project_iam"].each do |member, roles|
    roles.each do |role|
      describe google_project_iam_binding(
        project: input('output_project')[:project_id],
        role: role,
        # condition: { title: "my title" }
      ) do
        it { should exist }
        # its('members.count'){ should cmp 1 }
        its('members') { should include member }
        # its('condition.title') {should cmp 'my title' }
        # its('condition.expression') { should cmp "request.time < timestamp('2020-10-01T00:00:00.000Z')" }
      end
    end
  end
end

control 'local' do
end
