CloudFormation do

  alias_target = external_parameters.fetch(:alias_target, false)

  if alias_target == true
    Route53_RecordSet(:RecordSet) do
      HostedZoneName Ref(:HostedZoneName)
      Name Ref(:RecordName)
      Type 'A'
      AliasTarget do
        DNSName Ref(:AliasDNSName)
        HostedZoneId Ref(:AliasHostedZoneId)
      end
    end
  else
    Route53_RecordSet(:RecordSet) do
      HostedZoneName Ref(:HostedZoneName)
      Name Ref(:RecordName)
      Type Ref(:Type)
      TTL Ref(:TTL)
      ResourceRecords FnSplit(',', Ref(:ResourceRecords))
    end
  end

end