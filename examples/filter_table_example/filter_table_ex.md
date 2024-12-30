# Network Filtering and Handling System

This file defines a packet handling system that processes Ethernet and IP packets, using filters to determine whether to forward or drop them.

## Constants

- `OUT_PORT = 1`: Port for forwarded packets.
- `SERVER_PORT = 2`: Port for report generation.
- `DROP_PORT = 3`: Port for dropped packets.

## Types

### Ethernet Packet (`eth_t`)

- `dmac`: Destination MAC address (48 bits)
- `smac`: Source MAC address (48 bits)
- `etype`: Ethernet type (16 bits)

### IP Packet (`ip_t`)

- `src`: Source IP address (32 bits)
- `dst`: Destination IP address (32 bits)
- `len`: IP packet length (16 bits)

## Events

- `eth_ip`: Triggered by an Ethernet packet with IP.
- `prepare_report`: Prepares a report based on packet details.
- `report`: Represents a report with source, destination, and length.
- `packet_forwarded`: Triggered when a packet is forwarded.
- `packet_dropped`: Triggered when a packet is dropped.

## Tables

### `filter_table`

A table storing filtering rules based on source and destination IPs.

```c
global Table.t<<key_t, bool, (), bool>> filter_table = Table.create(1024, [mk_result], mk_result, false);
```
###  `Filtering Function`
```c
fun bool filter_with_table(ip_t ip) {
    bool r = Table.lookup(filter_table, {s=ip#src; d=ip#dst}, ());
    return r;
}
```