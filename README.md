# my-component CfHighlander Component

![cftest](https://github.com/theonestack/hl-route53-recordset/actions/workflows/rspec.yaml/badge.svg)


Creates a Route53 Recordset within a given HostedZone

```bash
kurgan add route53-recordset
```

## Requirements

## Parameters

| Name | Use | Default | Global | Type | Allowed Values |
| ---- | --- | ------- | ------ | ---- | -------------- |
| HostedZoneName | Hosted Zone for the record | None | false | string
| RecordName | the name of the record | None | false | string
| AliasDNSName | target alias DNS Name | None | false | string
| AliasHostedZoneId | target aliases HostedZone Id | None | false | string
| Type | DNS Record Type | CNAME | false | string | 'A','AAAA','CAA','CNAME','DS', 'MX','NAPTR','NS','PTR','SOA','SPF','SRV','TXT'
| TTL | TTL of the record | 60 | false | string
| ResourceRecords | Comma seperate string of target records | None | false | CommaDelimitedList



## Configuration

### Alias Target Recordset

To define a record as an Alias define the following config

```yaml
alias_target: true
```

You could also define this as an inlined config like

```ruby
  Component template: 'route53-recordset@0.1.0', name: 'myalias', config: { alias_target: true } do
    parameter name: 'HostedZoneName', value: FnSub("${EnvironmentName}.${DnsDomain}")
    parameter name: 'RecordName', value: FnSub("${EnvironmentName}.${DnsDomain}")
    parameter name: 'AliasDNSName', value: cfout('alb.LoadBalancerDNSName')
    parameter name: 'AliasHostedZoneId', value: cfout('alb.LoadBalancerCanonicalHostedZoneID')
  end

```

**Other Config Options**

See the test configs in the [tests directory](tests/)

## Outputs/Exports

| Name | Value | Exported |
| ---- | ----- | -------- |


## Development

```bash
gem install cfhighlander
```

or via docker

```bash
docker pull theonestack/cfhighlander
```

### Testing

Generate cftest

```bash
kurgan test example
```

Run cftest

```bash
cfhighlander cftest -t tests/example.test.yaml
```

or run all tests

```bash
cfhighlander cftest
```

Generate spec tests

```bash
kurgan test example --type spec
```

run spec tests

```bash
gem install rspec
```

```bash
rspec
```