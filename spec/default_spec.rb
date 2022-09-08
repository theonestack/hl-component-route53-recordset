require 'yaml'

describe 'compiled component route53-recordset' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/default.test.yaml")).to be_truthy
    end      
  end
  
  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/default/route53-recordset.compiled.yaml") }

  context "Parameters" do
    let(:parameters) { template["Parameters"] }

    it "has HostedZoneName parameter" do
        expect(parameters["HostedZoneName"]).to eq({
          "Default" => "",
          "NoEcho" => false,
          "Type" => "String",
        })
    end
  end

  context "Resources" do
    let(:resources) { template["Resources"] }

    it "has A Route53 Recordset" do
      expect(resources["RecordSet"]['Properties']).to eq({
        "HostedZoneName" => {"Ref"=>"HostedZoneName"},
        "Name" => {"Ref"=>"RecordName"},
        "ResourceRecords" => {"Fn::Split"=>[",", {"Ref"=>"ResourceRecords"}]},
        "TTL" => {"Ref"=>"TTL"},
        "Type" => {"Ref"=>"Type"},
      })
  end
  end
  
end