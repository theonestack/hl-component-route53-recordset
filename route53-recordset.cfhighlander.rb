CfhighlanderTemplate do
  
  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', allowedValues: ['development','production'], isGlobal: true
    ComponentParam 'HostedZoneName'
    ComponentParam 'RecordName'
    ComponentParam 'AliasDNSName', ''
    ComponentParam 'AliasHostedZoneId', ''
    ComponentParam 'Type', ''
    ComponentParam 'TTL', '60'
    ComponentParam 'ResourceRecords', ''
  end
  
  end