require 'yaml'

describe 'compiled component route53-recordset' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/alias_target.test.yaml")).to be_truthy
    end      
  end
  
  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/alias_target/route53-recordset.compiled.yaml") }

  context "Parameters" do
    let(:parameters) { template["Parameters"] }

    it "has EnvironmentName parameter" do
        expect(parameters["EnvironmentName"]).to eq({
          "Default" => "dev",
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
        "Type" => "A",
        "AliasTarget" => {
          "DNSName" => {"Ref"=>"AliasDNSName"},
          "HostedZoneId" => {"Ref"=>"AliasHostedZoneId"},
        },
      })
  end
  end
  
end