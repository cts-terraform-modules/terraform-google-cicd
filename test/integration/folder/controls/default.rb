# Load remaining variables
require 'yaml'
vars = YAML.load(File.read("test/variables/#{input('input_env_name')}.json"))

control 'gcp' do
  title 'GCP infrastructure tests'

  describe google_resourcemanager_folder(name: input('output_folder')[:id]) do
    it { should exist }
    its('display_name') { should eq vars['folder_name'] }
  end

  vars["folder_iam"].each do |member, roles|
    roles.each do |role|
      describe google_resourcemanager_folder_iam_binding(
        name: input('output_folder')[:id],
        role: role
      ) do
        it { should exist }
        its('members') { should include member }
      end
    end
  end
end

control 'local' do
  title 'Other tests'

end
