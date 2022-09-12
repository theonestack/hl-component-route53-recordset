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

    it "has RecordName parameter" do
        expect(parameters["RecordName"]).to eq({
          "Default" => "",
          "NoEcho" => false,
          "Type" => "String",
        })
    end

    it "has Type parameter" do
      expect(parameters["Type"]).to eq({
        "AllowedValues" => ["A", "AAAA", "CAA", "CNAME", "DS", "MX", "NAPTR", "NS", "PTR", "SOA", "SPF", "SRV", "TXT"],
        "Default" => "CNAME",
        "NoEcho" => false,
        "Type" => "String",
      })
    end

    it "has TTL parameter" do
      expect(parameters["TTL"]).to eq({
        "Default" => "60",
        "NoEcho" => false,
        "Type" => "String",
      })
    end

    it "has ResourceRecords parameter" do
      expect(parameters["ResourceRecords"]).to eq({
        "Default" => "",
        "NoEcho" => false,
        "Type" => "String",
      })
    end

    it "has no AliasDNSName parameter" do
      expect(parameters["AliasDNSName"]).to be_nil
    end

    it "has no AliasHostedZoneId parameter" do
      expect(parameters["AliasHostedZoneId"]).to be_nil
    end
  end

  context "Resources" do
    let(:resources) { template["Resources"] }

    it "has A Route53 Recordset" do
      expect(resources["RecordSet"]['Properties']).to eq({
        "HostedZoneName" => {"Fn::Join"=>["", [{"Ref"=>"HostedZoneName"}, "."]]},
        "Name" => {"Ref"=>"RecordName"},
        "ResourceRecords" => {"Fn::Split"=>[",", {"Ref"=>"ResourceRecords"}]},
        "TTL" => {"Ref"=>"TTL"},
        "Type" => {"Ref"=>"Type"},
      })
  end
  end
  
end