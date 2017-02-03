# Credability

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup)
    * [What Credability Affects](#what-credability-affects)
    * [Setup Requirements](#setup-requirements)
    * [Beginning with Credability](#beginning-with-credability)
1. [Usage](#usage)
1. [Reference](#reference)
1. [Limitations](#limitations)
1. [Development](#development)

## Description

Credability is a command line tool that wraps around the CredStash utility and
the AWS Ruby SDK. Credability allows you to query your CredStash data and fetch
secrets as well as authenticate to AWS vis the Ruby SDK to generate reports on
your infrastructure.

## Setup

Coming Soon...

### What Credability Affects

Coming Soon...

### Setup Requirements

  * Ruby >= 2.2.5
  * IAM User named 'reports.access.prod and 'reports.access.dev' with
    credentials kept in CredStash

More Coming Soon...

### Beginning with Credability

Coming Soon...

## Usage
```
Usage: credability [arguments]

Arguments:
  --help, -h: Print Help menu

  --region, -r: AWS Region to query

  --table, -t: DynamoDB Table to query for credentials

  --credstash, -c: CredStash action to take; get, list

  --cred_key: CredStash key for the credential to fetch

  --context: Comma separated key value pair encryption context

  --filter: Regex filter for CredStash list response data

  --report: The name of the report to run; or to list all reports

  --output: The output format; json, yaml, pretty

  --path: The path to create a report file
```

View list of available reports:
```
credability --report list
```

List CredStash items in a DynamoDB Table:
```
credability -r us-east-1 -t SuperSecretCreds -c list
```

Filter CredStash List Results:
```
credability -r us-east-1 -t SuperSecretCreds -c list --filter ^secret\.*\.creds$
```

Fetch credential from CredStash:
```
credability -r us-east-1 -t SuperSecretCreds -c get --cred_key secret.access.creds
```

Fetch credential from CredStash that uses Encryption-Context
```
credability -r us-east-1 -t SuperSecretCreds -c get --credkey secret.access.creds --context how_secret=super,really=yes
```

Output a console formatted Report:
```
credability -r us-east-1 -t SuperSecretCreds --report S3Buckets --output pretty
```

Output a JSON formatted Report:
```
credability -r us-east-1 -t SuperSecretCreds --report S3Buckets --output json
```

Output a YAML formatted Report:
```
credability -r us-east-1 -t SuperSecretCreds --report S3Buckets --output yaml
```

## Limitations

Coming Soon...

## Development

Coming Soon...

