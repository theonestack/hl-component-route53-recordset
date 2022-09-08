CfhighlanderTemplate do
  
  Parameters do
    ComponentParam 'HostedZoneName'
    ComponentParam 'RecordName'
    ComponentParam 'AliasDNSName', ''
    ComponentParam 'AliasHostedZoneId', ''
    ComponentParam 'Type', 'CNAME', allowedValues: ['A','AAAA','CAA','CNAME','DS', 'MX','NAPTR','NS','PTR','SOA','SPF','SRV','TXT']
    ComponentParam 'TTL', '60'
    ComponentParam 'ResourceRecords', ''
  end
  
  end