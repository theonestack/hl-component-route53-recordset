CfhighlanderTemplate do
  
  Parameters do
    ComponentParam 'HostedZoneName'
    ComponentParam 'RecordName'

    if alias_target
      ComponentParam 'AliasDNSName', ''
      ComponentParam 'AliasHostedZoneId', ''
    end
    
    unless alias_target
      ComponentParam 'Type', 'CNAME', allowedValues: ['A','AAAA','CAA','CNAME','DS', 'MX','NAPTR','NS','PTR','SOA','SPF','SRV','TXT']
      ComponentParam 'TTL', '60'
      ComponentParam 'ResourceRecords', ''
    end
  end
  
  end