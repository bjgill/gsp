# ADR021: Platform Alerting

## Status

Pending

## Context

The teams looking after a cluster need timely notification  based on key indicators in order that they can ensure reliability and respond to issues in a timely manner.

## Decision

We will use [Alert Manager](https://prometheus.io/docs/alerting/alertmanager/) for alerting in line with the standard [Reliability Engineering approach to Metrics and Alerting](https://reliability-engineering.cloudapps.digital/monitoring-alerts.html) and the [GDS Way guidance on alerting](https://gds-way.cloudapps.digital/standards/alerting.html#alerting)

## Consequences
- We will use the Reliability Engineering shared alert manager
