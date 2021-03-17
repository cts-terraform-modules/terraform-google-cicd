# Load remaining variables
require 'yaml'
vars = YAML.load(File.read("test/variables/dev.json"))

control "gcp" do
  title "GCP Resources"

  describe google_sourcerepo_repository(project: vars["project"], name: vars["repo_name"]) do
    it { should exist }
  end

  google_cloudbuild_triggers(project: vars["project"]).ids.each do |id|
    describe google_cloudbuild_trigger(project: vars["project"], id: id) do
      # its('filename') { should eq 'cloudbuild.yaml' }
      its('trigger_template.branch_name') { should eq vars["branch_name"] }
      its('trigger_template.repo_name') { should eq vars["repo_name"] }
      its('trigger_template.project_id') { should eq vars["project"] }
    end
  end

end

control "local" do
  title "Local resources"

  describe command("gcloud --project=#{vars["project"]} services list --enabled") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should match "sourcerepo.googleapis.com" }
  end
end
